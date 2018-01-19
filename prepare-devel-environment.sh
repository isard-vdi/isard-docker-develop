mkdir -p /isard/src/isard

git clone -b develop https://github.com/isard-vdi/isard /isard/src/isard
cp /isard/src/isard/isard.conf.docker /isard/src/isard/isard.conf
dnf install npm -y
npm install -g yarn
#bash -c "cd /isard/src/isard/install; yarn"

echo '#########################################################'
echo '#########################################################'
echo ' IMPORTANT!!!!'
echo ' You should check that selinux is not Enforcing:'
echo '    - check it with: getenforce'
echo ' If it is Enforcing you should disable it:'
echo '    - temporarily: setenforce 0'
echo '    - persistent: edit /etc/selinux/config'
echo '#########################################################'
echo '#########################################################'


echo '#########################################################'
echo 'Source is in /isard/src/isard'
echo 'You can start containers with:' 
echo '   docker-compose -f devel.yml up --build'
echo '      This will build images'
echo ' or'
echo '   docker-compose -f devel.yml up'
echo '      This will download images'
echo ''
echo ' Access to containers available through ssh:'
echo '    Engine: ssh root@host-machine -p 65022'
echo '    Webapp: ssh root@host-machine -p 65023'
echo 'Hypervisor: ssh root@host-machine -p 65024'
echo ' RethinkDB: http://host-machine:8080'
echo '            data access on host-machine tcp/28015'
echo ''
echo ' All passwords are:   isard'
echo '#########################################################'




