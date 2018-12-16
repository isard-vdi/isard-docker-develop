#!/bin/bash

cat <<EOF
Welcome to the marvambass/nginx-ssl-secure container

IMPORTANT:
  IF you use SSL inside your personal NGINX-config,
  you should add the Strict-Transport-Security header like:

    # only this domain
    add_header Strict-Transport-Security "max-age=31536000";
    # apply also on subdomains
    add_header Strict-Transport-Security "max-age=31536000; includeSubdomains";

  to your config.
  After this you should gain a A+ Grade on the Qualys SSL Test

EOF

DH_PREGEN="/dh.pem"
if [ -f "$DH_PREGEN" ]
then
    mv /dh.pem /etc/nginx/external/
fi

if [ -z ${DH_SIZE+x} ]
then
  >&2 echo ">> no \$DH_SIZE specified using default" 
  DH_SIZE="2048"
fi


DH="/etc/nginx/external/dh.pem"

if [ ! -e "$DH" ]
then
  echo ">> seems like the first start of nginx"
  echo ">> doing some preparations..."
  echo ""

  echo ">> generating $DH with size: $DH_SIZE"
  openssl dhparam -out "$DH" $DH_SIZE
fi



if [ ! -e "/etc/nginx/external/server-key.pem" ] || [ ! -e "/etc/nginx/external/server-cert.pem" ]
then
   echo ">> GENERATING NEW KEYS"
   bash /opt/auto-generate-certs.sh
fi

## server-key and server-cert could exist if it is a verified certificate.
## We should extract certificates from fullchain (server-cert.pem) and
## process it in isard app (move root ca from cert.2.pem to ca-cert.pem
## and only use it in libvirt, not int .vv files
if [ ! -e "/etc/nginx/external/ca-cert.pem" ]
    awk 'BEGIN {c=0;} /BEGIN CERT/{c++} { print > "cert." c ".pem"}' < server-cert.pem 
fi

chmod 440 /etc/nginx/external/*

echo ">> exec docker CMD"
echo "$@"
exec "$@"

