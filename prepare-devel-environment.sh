mkdir -p /isard/src/isard

git clone -b develop https://github.com/isard-vdi/isard /isard/src/isard
cp /isard/src/isard/isard.conf.docker /isard/src/isard/isard.conf
apk add npm 
npm install -g yarn

echo '#########################################################'
echo 'Source is in /isard/src/isard'
echo 'You can start containers with:' 
echo '   docker-compose -f devel-alpine.yml up --build'
echo '      This will build images'
echo ' or'
echo '   docker-compose -f devel-alpine.yml up'
echo '      This will download images'
echo ''
echo ' Access to containers available through ssh:'
echo '       App: ssh root@host-machine -p 65022'
echo 'Hypervisor: ssh root@host-machine -p 65024'
echo ' RethinkDB: http://host-machine:8080'
echo '            data access on host-machine tcp/28015'
echo ''
echo ' All passwords are:   isard'
echo '#########################################################'




