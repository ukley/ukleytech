Coloque aqui os certificados TLS usados pelo Nginx:

- fullchain.pem
- privkey.pem

Exemplo com Let's Encrypt:

cp /etc/letsencrypt/live/SEU_DOMINIO/fullchain.pem ./nginx/certs/fullchain.pem
cp /etc/letsencrypt/live/SEU_DOMINIO/privkey.pem ./nginx/certs/privkey.pem
