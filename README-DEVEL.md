# DEVELOPER ENVIRONMENT

To develop on Isard with docker we do recommend Fedora host (any version).

- Run: prepare-devel-environment.sh  (adapt it for host OS not Fedora)
- Run: docker-compose -f devel.yml up (this will download images)
- Aternatively you can build your images running: docker-compose -f devel.yml up --build

NOTE: To daemonize run docker-compose command with -d parameter

IMPORTANT: Disable selinux
