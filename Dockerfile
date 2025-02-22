#
# Cayley Docker
#
# https://github.com/davidp3/cayley-docker
#

FROM ubuntu
MAINTAINER David Parks davidp99@gmail.com

RUN \
  apt-get update && \
  apt-get install -y wget && \
  mkdir -p /opt/cayley

# To re-fetch latest from the github repo (instead of using cache), add
# `--build-arg='CACHE_DATE=$(date)'` to your `docker build` command.
# (TODO: Switch to a github release tag... when there is one.)
ARG CACHE_DATE=2016-06-01

RUN \
  wget https://raw.githubusercontent.com/davidp3/cayley-docker/master/cayley_0.4.1-trunk_linux_x64.tar.gz \
     -O - | tar -xvz --strip=1 -C /opt/cayley

RUN \
  cp /opt/cayley/cayley /usr/local/bin/

COPY cayley.cfg /data/cayley.cfg

# Define location of default conf file
ENV CAYLEY_CFG /data/cayley.cfg

# Set working directory
WORKDIR /opt/cayley

# Default commands
CMD echo $CAYLEY_CFG && cat $CAYLEY_CFG 1>&2 && \
    cayley init -config $CAYLEY_CFG -logtostderr=true && \
    cayley http -config $CAYLEY_CFG -logtostderr=true
