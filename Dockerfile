#
# Cayley Dockerfile
#
# https://github.com/davidp3/cayley-docker
#

# Pull base image.
FROM ubuntu
MAINTAINER David Parks davidp99@gmail.com

# Download Cayley binary.
RUN \
  apt-get update && \
  apt-get install -y wget && \
  mkdir -p /opt/cayley

RUN \
  wget https://github.com/google/cayley/releases/download/v0.4.1/cayley_0.4.1_linux_amd64.tar.gz \
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

# Expose ports.
EXPOSE 64321
