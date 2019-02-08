#!/bin/bash

# If the valhalla.json file doesn't exist, download new tiles and create a new file
if [ ! -f $VALHALLA_JSON ]; then
  # Download the needed pbf files(s)

  mkdir -p $VALHALLA_TILE_DIR
  cp /scripts/states.txt $VALHALLA_TILE_DIR
  /bin/bash /scripts/compile_states.sh $VALHALLA_DATA $VALHALLA_TILE_DIR

  # Check if we have the template file
  # if we don't have it, generate one
  # otherwise copy the template and fill in some of the values
  if [ ! -f $VALHALLA_JSON_TEMPLATE]; then
    valhalla_build_config \
      --mjolnir-tile-dir $VALHALLA_TILE_DIR \
      --mjolnir-tile-extract $VALHALLA_TILE_EXTRACT \
      > $VALHALLA_JSON
  else
    envsubst < $VALHALLA_JSON_TEMPLATE > $VALHALLA_JSON
  fi


  #build routing tiles
  valhalla_build_tiles \
    -c $VALHALLA_JSON \
    $VALHALLA_DATA

  #tar it up for running the server
  find $VALHALLA_TILE_DIR | \
    sort -n | \
    tar cf $VALHALLA_TILE_EXTRACT --no-recursion --absolute-names -T -

  rm -rf $VALHALLA_TILE_DIR
fi

#start up the server
cat logo.txt
valhalla_service $VALHALLA_JSON 1
