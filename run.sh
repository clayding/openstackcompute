#!/bin/sh

if [ $# != 2 ];
then
echo "Usage:"
echo "	bash run.sh [host name] [image name]"
echo "Example:"
echo "	bash run.sh OpenstackCompute clayding/openstackcompute:v1.0.0"
fi

host_name=$1
imagename=$2

docker run --privileged=true --network host --rm -h ${host_name} -it ${imagename} /usr/sbin/init
