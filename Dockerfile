FROM ubuntu:22.04

# Update and install necessary libraries for ns3
RUN apt-get update && apt-get install g++ -y \
    tar \
    wget \
    g++ \
    python3 \
    python3-pip \
    cmake \
    ninja-build \
    git

# Install python packages for ns3
RUN apt install  -y \
    libzmq5 \
    libzmq3-dev \
    libprotobuf-dev \
    protobuf-compiler \
    pkg-config

# Grab and install ns3-3.36
WORKDIR /root
RUN wget https://www.nsnam.org/releases/ns-allinone-3.39.tar.bz2
RUN tar -xjf ns-allinone-3.39.tar.bz2

# Add ns3-gym to ns3
WORKDIR /root/ns-allinone-3.39/ns-3.39/contrib
RUN git clone https://github.com/tkn-tub/ns3-gym.git ./opengym
WORKDIR /root/ns-allinone-3.39/ns-3.39/contrib/opengym
RUN git checkout app-ns-3.36+
WORKDIR /root/ns-allinone-3.39/ns-3.39/

# Build ns3
RUN ./ns3 configure --enable-examples
RUN ./ns3 build

# Install ns3gym
WORKDIR /root/ns-allinone-3.39/ns-3.39/contrib/opengym
RUN pip3 install --user ./model/ns3gym