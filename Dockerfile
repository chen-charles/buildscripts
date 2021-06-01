FROM ubuntu:focal

RUN DEBIAN_FRONTEND="noninteractive" apt update
RUN DEBIAN_FRONTEND="noninteractive" apt install -y cmake git build-essential autoconf texinfo bison flex pkg-config wget bash

COPY . /src
RUN mkdir build && cd build && cmake ../src && make -j$(nproc)

FROM ubuntu:focal

ENV VITASDK /home/user/vitasdk
ENV PATH ${VITASDK}/bin:$PATH

COPY --from=0 /build/vitasdk ${VITASDK}
