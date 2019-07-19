FROM ubuntu:18.04
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
      libprotobuf-dev \
      libtool \
      make \
      nodejs \
      osmctools \
      pkg-config \
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
      lua5.2 \
      wget \
    && rm -rf /var/lib/apt/lists/*

# Install the latest stable version of nodejs
# RUN npm install -g n && \
    # n stable && \
    # ln -sf $(n bin stable) /usr/bin/node
#if you plan to compile with node bindings, run


ENV NODE_VERSION=10.15.0
ENV NVM_DIR=$HOME/.nvm
ENV NODEJS_INCLUDE_DIRS=$NVM_DIR/versions/node/v$NODE_VERSION/include
RUN mkdir -p $NODEJS_INCLUDE_DIRS

RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash

RUN [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
RUN . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH
RUN ln -s $NVM_DIR/versions/node/v$NODE_VERSION/include/node/node.h /usr/include/node.h
RUN ln -s $NVM_DIR/versions/node/v$NODE_VERSION/include/node/uv.h /usr/include/uv.h
RUN ln -s $NVM_DIR/versions/node/v$NODE_VERSION/include/node/v8.h /usr/include/v8.h

# Then clone and build prime_server.
# After getting the dependencies install it with:
RUN git clone https://github.com/valhalla/valhalla.git && \
    cd /valhalla && \
    git submodule update --init --recursive && \
    npm install --ignore-scripts && \
    npm install && \
    mkdir build && \
    cd build && \
    cmake .. -DCMAKE_BUILD_TYPE=Release -DENABLE_PYTHON_BINDINGS=On -DENABLE_SERVICES=OFF && \
    make -j$(nproc) && \
    make install

# Copy the logo over, because it's fun
RUN mkdir -p /temp/valhalla
COPY logo.txt /logo.txt
