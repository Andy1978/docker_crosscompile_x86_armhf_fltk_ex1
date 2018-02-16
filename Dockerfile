FROM debian:stretch-slim

RUN dpkg --add-architecture armhf && apt-get update
RUN apt-get install -y gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf
RUN apt-get install -y libfltk1.3-dev:armhf
RUN apt-get install -y make

WORKDIR /app

COPY hello.fl Makefile /app/

CMD ["/bin/bash"]
