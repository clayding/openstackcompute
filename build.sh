#!/bin/sh

if [ $# != 1 ];
then
echo "Usage:"
echo "  bash build.sh [image name]"
echo "Example:"
echo "  bash build.sh clayding/openstackcompute:v1.0.0"
exit 0
fi

imagename=$1

docker build --no-cache --network=host -t ${imagename} .
