#!/bin/bash

if [ "${CONTROLLER_IP}x" == "x" ]; then
echo "CONTROLLER_IP not set"
exit 1
elif [ "${COMPUTE_IP}x" == "x" ]; then
echo "COMPUTE_IP not set"
exit 1
elif [ "${PROVIDER_INTERFACE}x" == "x" ]; then
echo "PROVIDER_INTERFACE not set"
exit 1
fi

if [ "${1}x" == "old" ]; then
mv /etc/nova/nova.conf.backup /etc/nova/nova.conf
mv  /etc/neutron/neutron.conf.backup  /etc/neutron/neutron.conf
mv /etc/neutron/plugins/ml2/linuxbridge_agent.ini.backup /etc/neutron/plugins/ml2/linuxbridge_agent.ini
echo "Config files restored"
exit
fi

# Backup configuration files
cp /etc/nova/nova.conf /etc/nova/nova.conf.backup
cp /etc/neutron/neutron.conf /etc/neutron/neutron.conf.backup
cp /etc/neutron/plugins/ml2/linuxbridge_agent.ini /etc/neutron/plugins/ml2/linuxbridge_agent.ini.backup

# Set variables
echo "Set CONTROLLER_IP=$CONTROLLER_IP into /etc/nova/nova.conf"
sed -i "s/XXX_CONTROLLER_IP_XXX/$CONTROLLER_IP/g" /etc/nova/nova.conf

echo "Set COMPUTE_IP=$COMPUTE_IP into /etc/nova/nova.conf"
sed -i "s/XXX_COMPUTE_IP_XXX/$COMPUTE_IP/g" /etc/nova/nova.conf

echo "Set CONTROLLER_IP=$CONTROLLER_IP into /etc/neutron/neutron.conf"
sed -i "s/XXX_CONTROLLER_IP_XXX/$CONTROLLER_IP/g" /etc/neutron/neutron.conf

echo "Set PROVIDER_INTERFACE=$PROVIDER_INTERFACE into /etc/neutron/plugins/ml2/linuxbridge_agent.ini"
# sed -i "s/XXX_COMPUTE_IP_XXX/$COMPUTE_IP/g" /etc/neutron/neutron.conf
sed -i "s/XXX_PROVIDER_INTERFACE_XXX/$PROVIDER_INTERFACE/g" /etc/neutron/plugins/ml2/linuxbridge_agent.ini

echo "Configure done"

# Start services
# Enable and start nova services on compute node
systemctl restart libvirtd.service openstack-nova-compute.service

# Enable and start neutron services on compute node
systemctl restart neutron-linuxbridge-agent.service
