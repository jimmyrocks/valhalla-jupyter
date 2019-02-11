FROM python:stretch
MAINTAINER jimmyrocks

RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
      python3-rtree \
    && rm -rf /var/lib/apt/lists/*

# Add custom libraries
RUN python3 -m pip install --upgrade pip &&\
    python3 -m pip install \
      jupyter \
      ipyleaflet \
      psycopg2-binary \
      rtree \
      requests \
      geopandas
