FROM ubuntu:16.04
MAINTAINER jimmyrocks

# Allow for the add-apt-repository function
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
      software-properties-common \
    && rm -rf /var/lib/apt/lists/*

RUN add-apt-repository -y ppa:valhalla-core/valhalla

RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
      cmake \
      curl \
      g++ \
      gcc \
      git \
      jq \
      lcov \
      libboost-all-dev \
      libboost-all-dev \
      libcurl4-openssl-dev \
      liblz4-dev \
      libprime-server0.6.3-dev \
      libprotobuf-dev \
      libtool \
      make \
      nodejs \
      npm \
      osmctools \
      pkg-config \
      prime-server0.6.3-bin \
      protobuf-compiler \
      vim-common \
      zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

#if you plan to compile with data building support, see below for more info
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
      libgeos++-dev \
      libgeos-dev \
      liblua5.2-dev \
      libspatialite-dev \
      libsqlite3-dev \
      libsqlite3-mod-spatialite \
      lua5.2\
      python-all-dev \
      wget \
    && rm -rf /var/lib/apt/lists/*

# Install the latest stable version of nodejs
RUN npm install -g n && \
    n stable && \
    ln -sf $(n bin stable) /usr/bin/node

# Then clone and build prime_server.
# After getting the dependencies install it with:
RUN git clone https://github.com/valhalla/valhalla.git && \
    cd /valhalla && \
    git submodule update --init --recursive && \
    npm install --ignore-scripts && \
    npm install && \
    mkdir build && \
    cd build && \
    cmake .. -DCMAKE_BUILD_TYPE=Release -DENABLE_PYTHON_BINDINGS=On && \
    make -j$(nproc) && \
    make install

# Copy the logo over, because it's fun
RUN mkdir -p /temp/valhalla
COPY logo.txt /logo.txt
