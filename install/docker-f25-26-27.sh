sudo dnf -y remove docker \
                  docker-common \
                  container-selinux \
                  docker-selinux \
                  docker-engine
sudo dnf -y install dnf-plugins-core
sudo dnf -y config-manager \
    --add-repo \
    https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf -y makecache 
#sudo dnf config-manager --set-enabled docker-ce-test
sudo dnf -y install docker-ce docker-compose -y
sudo systemctl enable docker
sudo systemctl start docker
