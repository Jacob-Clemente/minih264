# Build Stage
FROM --platform=linux/amd64 ubuntu:20.04 as builder

## Install build dependencies.
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y cmake

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y libpthread-stubs0-dev

## Add source code to the build stage.
ADD . /minih264
WORKDIR /minih264

## TODO: ADD YOUR BUILD INSTRUCTIONS HERE.
RUN gcc *.c -L /usr/lib/ -lpthread -lm -o minih264

#Package Stage
FROM --platform=linux/amd64 ubuntu:20.04

## TODO: Change <Path in Builder Stage>
COPY --from=builder /minih264/minih264 /
