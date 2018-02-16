.PHONY: build run dist clean

# crosscompile inside a docker container
CROSS_COMPILE := arm-linux-gnueabihf-
TAG := fltk_crosscompile

CXX := $(CROSS_COMPILE)g++
CC := $(CROSS_COMPILE)gcc

build: build-container
	rm -rf out && mkdir out
	sudo docker run --mount type=bind,source=`pwd`/out,target=/app/out $(TAG) bash -c "make hello && cp hello ./out"
	@echo "\nNow copy ./out/hello to an armhf machine, for example a Raspberry Pi and execute it"

build-container:
	sudo docker build -t $(TAG) .

run: build-container
	sudo docker run -it $(TAG)

%.cc %.h: %.fl
	fluid -c -o .cc $<

%: %.cc %.h
	$(CXX) -Wall `fltk-config --ldflags` $< -o $@

clean:
	rm -rf out
