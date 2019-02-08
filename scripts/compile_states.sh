#!/bin/bash

# Choose states to download
output_file="$1"
root_directory="$2"
states=$(grep -v "^#" $root_directory/states.txt | sed 's/.*/\L&/' | sed 's/\s/-/')

# Download selected states
echo $output_file
echo $root_directory
echo $states
for state in ${states[@]}
do
  curl -o "$root_directory/routing-tiles-$state.pbf" "http://download.geofabrik.de/north-america/us/$state-latest.osm.pbf"
done

# Convert pbf files to osm files (merging doesn't work with pbf files)
echo "Converting to OSM format"
declare -a FILELIST
for f in $root_directory/routing-tiles-*.pbf
do
  echo "Converting $f"
  osmconvert "$f" > "${f%.*}.osm"
  FILELIST+="${f%.*}.osm ";
  rm "$f"
done

# Combine the OSM files into a single pbf file
echo "Merging files: " $FILELIST
osmconvert ${FILELIST[*]} -o="$output_file" --out-pbf
rm ${FILELIST[*]}
