# Publicacao do dominio ukleytech.com.br

## 1) Modo padrao: somente Apache (sem Nginx e sem TLS no projeto)
Este projeto roda diretamente com `apache2` dentro do container `php:8.2-apache`.

Subir:

```bash
docker compose up -d --build
```

Teste local/publico em HTTP:

```bash
curl -I http://ukleytech.com.br
curl -I http://www.ukleytech.com.br
```

## 2) DNS (no provedor do dominio)
Aponte o dominio para o IP publico do servidor.

Registros recomendados:

- A `@` -> `IP_PUBLICO_SERVIDOR`
- A `www` -> `IP_PUBLICO_SERVIDOR`

Opcional (IPv6):

- AAAA `@` -> `IPV6_SERVIDOR`
- AAAA `www` -> `IPV6_SERVIDOR`

## 3) Modo opcional com Traefik (sem SSL/TLS)
Use `docker-compose.traefik.yml` apenas se voce ja tem Traefik no servidor e quer rotear em HTTP.

1. Garantir rede externa do Traefik:
```bash
docker network create traefik-public || true
```
2. Subir:
```bash
docker compose -f docker-compose.traefik.yml up -d --build
```

## 4) Validacao

```bash
curl -I http://ukleytech.com.br
curl -I http://www.ukleytech.com.br
```

Esperado:

- ambos respondem via HTTP de acordo com a regra configurada no servidor/proxy
