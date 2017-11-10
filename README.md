# IsardVDI dockers

## Start a complete virtualization environtment

- Install docker & docker-compose: https://docs.docker.com/compose/install/
	For your convenience there is a Fedora25 automated script on install folder

- Run: docker-compose up
	It will download images and start containers. When finished connect to:
	https://<your-ip>

## Defaults

Default user is admin and passwd isard.

## First virtual machine

Go to domains page and add new from virt-builder. You will get a completely functional OS when the process finishes (15/30 minutes depending on Internet connection)

### Notes
	It will only expose TCP/443 port. Be sure that you don't have any other web wervice on that port
	It will create virtual disks on /isard on host computer.
