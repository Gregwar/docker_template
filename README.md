# Docker template

## Operation

* Building: `make`
* Running: `make run`
* SSH-ing into the container: `make ssh`
* Stopping: `make stop`
* Removing the container: `make rm`
* Removing the image and container (cleaning): `make clean`

The `/app` folder on the image is mounted to the `./app` folder on the host.

## Customization

* Changing the name: edit the top of the `Makefile`
* Adding APT packages: edit the `Dockerfile`
* Exposing ports: edit the `rubn` section of the `Makefile`