# Instructions:
# $ docker build -t icu-demo .
# $ docker run icu-demo /root/icu-demo/demo

FROM debian:jessie
COPY . /root/icu-demo
RUN cd /root && \

  # Install build tools like GCC.
  echo 'deb http://httpredir.debian.org/debian sid main' >> \
    /etc/apt/sources.list && \
  DEBIAN_FRONTEND=noninteractive apt-get -y update && \
  DEBIAN_FRONTEND=noninteractive apt-get -y install \
  build-essential && \

  # Build the demo.
  cd icu-demo && make
