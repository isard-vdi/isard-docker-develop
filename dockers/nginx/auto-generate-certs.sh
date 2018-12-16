cd /etc/nginx/external

# Self signed cert generic data
C=CA
L=Barcelona
O=localdomain
CN_CA=$O
CN_HOST=*.$O
OU=$O

echo 'Using the openssl command, create a 2048-bit RSA key:'
openssl genrsa -out ca-key.pem 2048

echo 'Use the key to create a self-signed certificate to your local CA:'
openssl req -new -x509 -days 9999 -key ca-key.pem -out ca-cert.pem -sha256 \
        -subj "/C=$C/L=$L/O=$O/CN=$CN_CA"

echo 'Create Server'
openssl genrsa -out server-key.pem 2048

echo 'Create a certificate signing request for the server.'
openssl req -new -key server-key.pem -sha256 -out server-key.csr \
          -subj "CN=$CN_HOST"

echo 'Create  server certificates:'
openssl x509 -req -days 3650 -in server-key.csr -CA ca-cert.pem -CAkey ca-key.pem \
          -set_serial 94345 -sha256 -out server-cert.pem
          
chmod 440 *
cd /
