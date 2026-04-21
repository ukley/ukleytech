# Publicacao do dominio ukleytech.com.br

## 1) DNS (no provedor do dominio)
Aponte o dominio para o IP publico do servidor onde o Docker roda.

Registros recomendados:

- A `@` -> `IP_PUBLICO_SERVIDOR`
- A `www` -> `IP_PUBLICO_SERVIDOR`

Opcional (IPv6):

- AAAA `@` -> `IPV6_SERVIDOR`
- AAAA `www` -> `IPV6_SERVIDOR`

## 2) Firewall e portas
No servidor, libere:

- TCP 80
- TCP 443

## 3) Subir containers
No projeto:

```bash
docker compose up -d --build
```

## 4) Emitir certificado TLS (Let's Encrypt)
Com DNS ja propagado, no servidor:

```bash
sudo certbot certonly --standalone -d ukleytech.com.br -d www.ukleytech.com.br
```

Copie os certificados para o projeto:

```bash
sudo cp /etc/letsencrypt/live/ukleytech.com.br/fullchain.pem ./nginx/certs/fullchain.pem
sudo cp /etc/letsencrypt/live/ukleytech.com.br/privkey.pem ./nginx/certs/privkey.pem
sudo chown $(id -u):$(id -g) ./nginx/certs/fullchain.pem ./nginx/certs/privkey.pem
```

Reinicie o Nginx:

```bash
docker compose restart nginx
```

## 5) Validacao
Teste:

```bash
curl -I http://ukleytech.com.br
curl -I http://www.ukleytech.com.br
curl -I https://ukleytech.com.br
curl -I https://www.ukleytech.com.br
```

Esperado:

- HTTP redireciona para `https://ukleytech.com.br`
- `https://www.ukleytech.com.br` redireciona para `https://ukleytech.com.br`
- `https://ukleytech.com.br` responde 200
