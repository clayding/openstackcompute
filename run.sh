#!/bin/sh

if [ $# != 5 ];
then
echo "Usage:"
echo "	bash run.sh [host name] [image name] [controller ip] [compute ip] [provider interface]"

echo "Options:"
echo "	host name:          Set the hostname for being created container"
echo "	image name:         Specify image's name from which the container is created"
echo "	controller ip:      IP address of controller node on which the keystone, rabbitMQ are running"
echo "	compute ip:         Management IP address on compute node (same subnet with controller ip)"
echo "	provider interface: Network interface for provider network"


echo "Example:"
echo "	bash run.sh OpenstackCompute clayding/openstackcompute:v1.0.0 192.168.100.110 192.168.100.12 eth0"

exit 0
fi

host_name=$1
imagename=$2
controlip=$3
computeip=$4
provideif=$5

runcmd="docker run --privileged=true --network host --rm -h ${host_name} \
-e CONTROLLER_IP="$controlip" -e COMPUTE_IP=$computeip -e PROVIDER_INTERFACE=$provideif \
-it ${imagename} /usr/sbin/init"

echo "Command: $runcmd"
$runcmd
