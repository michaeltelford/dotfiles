# For testing these dotfiles on a debian docker image
#
# To execute bash on this image, from this dir run:
#
# docker rmi -f dotfiles; docker build -t dotfiles . && docker run --rm -it --name dotfiles dotfiles bash
#
# Then to test new changes run the following in the container bash shell:
#
# su default
# make install (or otherwise)
#

FROM debian:wheezy-slim

RUN apt-get update && apt-get install -y --force-yes \
		apt-utils \
		build-essential \
		python-setuptools \
    gawk \
    nano \
		ruby \
		curl \
		bash \
		git

RUN useradd --shell /bin/bash default && \
	mkdir /home/default && chown default:users /home/default

COPY . /dotfiles
RUN chmod -R o+rwx /dotfiles
WORKDIR /dotfiles

CMD [ "bash" ]
