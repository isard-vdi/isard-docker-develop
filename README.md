# IsardVDI dockers

IMPORTANT: It doesn't work as expected if host has ipv6 addresses!!


## Start a complete virtualization environtment

- Install docker & docker-compose: https://docs.docker.com/compose/install/

	For your convenience there is a Fedora automated script on install folder

- Download or build the images:

    To download the images run:
    docker-compose pull

    To build the images run:
    docker-compose build

- Run: docker-compose up -d

	It will start containers. When finished connect to:
	https://<your-ip>

NOTE: Containers will start automatically next time you start or restart docker service (systemctl start docker)

## Wizard

Installation wizard is provided for first time installation on https://<your-ip>
NOTE: Please check download updates to get example domains ready to use

## First virtual machine

Go to domains page and add new from virt-builder. You will get a completely functional OS when the process finishes (15/30 minutes depending on Internet connection)

### Notes
	It will only expose TCP/443 port. Be sure that you don't have any other web wervice on that port
	It will create virtual disks on /isard on host computer.
