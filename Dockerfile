# To execute bash on this image, from this dir run:
#
# docker rmi -f dotfiles; docker build -t dotfiles . && docker run --rm -it --name dotfiles dotfiles bash

# Then to test new changes run the following in the container bash shell:
#
# su default
# bash
# make install

FROM debian:wheezy-slim

COPY . /dotfiles
RUN chmod -R o+rwx /dotfiles
WORKDIR /dotfiles

RUN apt-get update && apt-get install -y --force-yes \
		apt-utils \
		build-essential \
		python-setuptools \
    gawk \
		ruby \
		curl \
		bash \
		git

RUN useradd --shell /bin/bash default && mkdir /home/default && chown default:users /home/default
