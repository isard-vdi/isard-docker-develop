#~ spice_key="/etc/nginx/external/server-key.pem"
#~ if [ -f "$spice_key" ]
#~ then
    #~ echo "$spice_key found, so not generating new spice certificates."
    #~ exit 1
#~ fi

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

echo 'Create Server & client keys'
openssl genrsa -out server-key.pem 2048

echo 'Create a certificate signing request for the server. Remember to change the kvmhost.company.org address (used in the server certificate request) to the fully qualified domain name of your KVM host:'
openssl req -new -key server-key.pem -sha256 -out server-key.csr \
          -subj "/C=$C/O=$O/CN=$CN_HOST"

echo 'Create client and server certificates:'
openssl x509 -req -days 3650 -in server-key.csr -CA ca-cert.pem -CAkey ca-key.pem \
          -set_serial 94345 -sha256 -out server-cert.pem
          
chmod 440 *
cd /
