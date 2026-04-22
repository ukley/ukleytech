# Publicacao do dominio ukleytech.com.br

## 1) Diagnostico rapido do erro atual
Se o `curl https://ukleytech.com.br` retornar algo como:

- certificado `TRAEFIK DEFAULT CERT`
- resposta HTTP `404 page not found`

entao o dominio esta chegando no Traefik sem rota para este projeto.

## 2) DNS (no provedor do dominio)
Aponte o dominio para o IP publico do servidor que recebe trafego web.

Registros recomendados:

- A `@` -> `IP_PUBLICO_SERVIDOR`
- A `www` -> `IP_PUBLICO_SERVIDOR`

Opcional (IPv6):

- AAAA `@` -> `IPV6_SERVIDOR`
- AAAA `www` -> `IPV6_SERVIDOR`

## 3) Escolha do modo de deploy
Use apenas um dos modos abaixo.

### Modo A: servidor dedicado com Nginx deste projeto
Use `docker-compose.yml` (Nginx exposto em `80/443`).

1. Subir:
```bash
docker compose up -d --build
```
2. Emitir TLS:
```bash
sudo certbot certonly --standalone -d ukleytech.com.br -d www.ukleytech.com.br
```
3. Copiar certificado:
```bash
sudo cp /etc/letsencrypt/live/ukleytech.com.br/fullchain.pem ./nginx/certs/fullchain.pem
sudo cp /etc/letsencrypt/live/ukleytech.com.br/privkey.pem ./nginx/certs/privkey.pem
sudo chown $(id -u):$(id -g) ./nginx/certs/fullchain.pem ./nginx/certs/privkey.pem
docker compose restart nginx
```

### Modo B: servidor com Traefik ja existente
Use `docker-compose.traefik.yml` (sem expor portas locais neste projeto).

1. Garantir rede externa do Traefik:
```bash
docker network create traefik-public || true
```
2. Subir:
```bash
docker compose -f docker-compose.traefik.yml up -d --build
```
3. Conferir se o Traefik tem entrypoints `web` e `websecure` e certresolver `letsencrypt`.

## 4) Validacao
Execute:

```bash
curl -I http://ukleytech.com.br
curl -I http://www.ukleytech.com.br
curl -I https://ukleytech.com.br
curl -I https://www.ukleytech.com.br
```

Esperado:

- HTTP redireciona para HTTPS
- `https://www.ukleytech.com.br` redireciona para `https://ukleytech.com.br`
- `https://ukleytech.com.br` responde `200 OK`

Cheque o certificado servido:

```bash
echo | openssl s_client -servername ukleytech.com.br -connect ukleytech.com.br:443 2>/dev/null | openssl x509 -noout -subject -ext subjectAltName
```

O certificado valido deve listar `DNS:ukleytech.com.br` (e opcionalmente `DNS:www.ukleytech.com.br`).
