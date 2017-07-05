mkdir -p /isard/src/isard

git clone -b development https://github.com/isard-vdi/isard /isard/src/isard
cp run_docker_* /isard/src/isard
cp dockers/isard.conf /isard/src/isard
dnf install npm -y
npm install -g bower
bash -c "cd /isard/src/isard/install; bower install --allow-root"
echo '\n\nSource is in /isard/src/isard'
echo '\nYou can start containers with: docker-compose -f docker-compose-devel.yml up --build'
echo '    Engine: ssh root@host-machine -p 65022'
echo '    Webapp: ssh root@host-machine -p 65023'
echo 'Hypervisor: ssh root@host-machine -p 65024'
echo ' RethinkDB: http://host-machine:8080'
echo '            data access on host-machine tcp/28015'




