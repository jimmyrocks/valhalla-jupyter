#!/bin/bash

VALHALLA_JSON=/data/valhalla/valhalla.json
VALHALLA_DATA=/data/valhalla/state_data.pbf
VALHALLA_TILE_DIR=/temp/valhalla/tiles
VALHALLA_TILE_TAR=/data/valhalla/state_data.tar

# If the valhalla.json file doesn't exist, download new tiles and create a new file
if [ ! -f $VALHALLA_JSON ]; then
  # Download the needed pbf files(s)

  mkdir -p $VALHALLA_TILE_DIR
  cp /scripts/states.txt $VALHALLA_TILE_DIR
  /bin/bash /scripts/compile_states.sh $VALHALLA_DATA $VALHALLA_TILE_DIR

  # TODO, use existing file from conf directory and only replace
  #   "tile_dir", "tile_extract", "listen"
  valhalla_build_config \
    --mjolnir-tile-dir $VALHALLA_TILE_DIR \
    --mjolnir-tile-extract $VALHALLA_TILE_TAR \
    > $VALHALLA_JSON

  #build routing tiles
  valhalla_build_tiles \
    -c $VALHALLA_JSON \
    $VALHALLA_DATA

  #tar it up for running the server
  find $VALHALLA_TILE_DIR | \
    sort -n | \
    tar cf $VALHALLA_TILE_TAR --no-recursion --absolute-names -T -

  rm -rf $VALHALLA_TILE_DIR
  rm -rf $VALHALLA_DATA
fi

#start up the server
cat logo.txt
valhalla_service $VALHALLA_JSON 1
