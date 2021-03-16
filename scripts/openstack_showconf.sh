#!/bin/bash

########################Show configuration sections#####################
echo "# grep "^[a-z]" /etc/nova/nova.conf"
grep "^[a-z]" /etc/nova/nova.conf

echo
echo
echo "# grep "^[a-z]" /etc/neutron/neutron.conf"
grep "^[a-z]" /etc/neutron/neutron.conf

echo
echo
echo "#grep "^[a-z]" /etc/neutron/plugins/ml2/linuxbridge_agent.ini"
grep "^[a-z]" /etc/neutron/plugins/ml2/linuxbridge_agent.ini
