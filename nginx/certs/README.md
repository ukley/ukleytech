Coloque aqui os certificados TLS usados pelo Nginx:

- fullchain.pem
- privkey.pem

Os arquivos devem conter o certificado para os dois hostnames:

- ukleytech.com.br
- www.ukleytech.com.br

Exemplo com Let's Encrypt (certbot):

cp /etc/letsencrypt/live/ukleytech.com.br/fullchain.pem ./nginx/certs/fullchain.pem
cp /etc/letsencrypt/live/ukleytech.com.br/privkey.pem ./nginx/certs/privkey.pem
