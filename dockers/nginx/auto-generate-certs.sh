spice_key="/etc/pki/libvirt-spice/server-key.pem"
if [ -f "$spice_key" ]
then
    echo "$spice_key found, so not generating new spice certificates."
    exit 1
fi


C=CA
L=Barcelona
O=localdomain
CN_CA=$O
CN_HOST=*.$O
OU=$O

echo 'Using the openssl command, create a 2048-bit RSA key:'
openssl genrsa -out cakey.pem 2048

echo 'Use the key to create a self-signed certificate to your local CA:'
openssl req -new -x509 -days 9999 -key cakey.pem -out cacert.pem -sha256 \
        -subj "/C=$C/L=$L/O=$O/CN=$CN_CA"

echo 'Check your CA certificate:'
openssl x509 -noout -text -in cacert.pem

echo 'Create Server & client keys'
openssl genrsa -out serverkey.pem 2048
openssl genrsa -out clientkey.pem 2048

echo 'Create a certificate signing request for the server. Remember to change the kvmhost.company.org address (used in the server certificate request) to the fully qualified domain name of your KVM host:'
openssl req -new -key serverkey.pem -sha256 -out serverkey.csr \
          -subj "/C=$C/O=$O/CN=$CN_HOST"

echo 'Create a certificate signing request for the client:'
openssl req -new -key clientkey.pem -sha256 -out clientkey.csr \
          -subj "/C=$C/O=$O/OU=$OU/CN=root"

echo 'Create client and server certificates:'
openssl x509 -req -days 3650 -in clientkey.csr -CA cacert.pem -CAkey cakey.pem \
          -set_serial 1 -sha256 -out clientcert.pem
openssl x509 -req -days 3650 -in serverkey.csr -CA cacert.pem -CAkey cakey.pem \
          -set_serial 94345 -sha256 -out servercert.pem

#mkdir -p /etc/pki
#mkdir -p /etc/pki/libvirt-spice
mv cacert.pem /etc/nginx/external/ca-cert.pem
mv servercert.pem /etc/nginx/external/server-cert.pem
mv serverkey.pem /etc/nginx/external/server-key.pem
mv clientcert.pem /etc/nginx/external/client-cert.pem
#chown qemu /etc/nginx/external/*
chmod 440 /etc/nginx/external/*
#systemctl restart libvirtd
#echo '4.- Modify /etc/libvirt/qemu.conf to activate certificate with spice'
#echo '    spice_tls = 1'
#echo '    spice_tls_x509_cert_dir = "/etc/pki/libvirt-spice"'
