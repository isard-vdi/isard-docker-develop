sh auto-generate-certs.sh &
sh customlibvirtpost.sh &
libvirtd 
sshd &
while true; do sleep 30; done;

