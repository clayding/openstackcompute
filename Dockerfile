#FROM centos:7
#FROM gar-registry.caas.intel.com/duckerdev/openstackcompute:v1.0.0
FROM clayding/openstackcompute:v1.0.1
LABEL maintainer=shikun.ding@intel.com

# update os and add required bundles
#RUN yum -y update \
#        && yum install -y python3-pip make gcc gcc-c++ \
#         glib2 gtk2 git curl wget iproute2 iproute2-doc net-tools \
#         sudo pciutils

#RUN yum clean all && yum makecache && yum -y update && \
#        yum install -y sudo iproute2 iproute2-doc net-tools file


# Install the packages
#RUN yum install -y centos-release-openstack-train
#RUN yum install -y openstack-nova-compute
RUN yum install -y openstack-neutron-linuxbridge ebtables ipset

# Override configuration files
COPY conf/nova/nova.conf /etc/nova/nova.conf
COPY conf/neutron/neutron.conf /etc/neutron/neutron.conf
COPY conf/neutron/plugins/ml2/linuxbridge_agent.ini /etc/neutron/plugins/ml2/linuxbridge_agent.ini

# Change the permisson of duplicated files
RUN chmod 640 /etc/nova/nova.conf
RUN chown root:nova /etc/nova/nova.conf
RUN chmod 640 /etc/neutron/neutron.conf
RUN chmod 640 /etc/neutron/plugins/ml2/linuxbridge_agent.ini

RUN echo "/proc/sys/net/bridge/bridge-nf-call-iptables value:" > /tmp/openstackcompute.log
RUN cat /proc/sys/net/bridge/bridge-nf-call-iptables >> /tmp/openstackcompute.log

RUN echo "/proc/sys/net/bridge/bridge-nf-call-ip6tables value:" >> /tmp/openstackcompute.log
RUN cat /proc/sys/net/bridge/bridge-nf-call-ip6tables >> /tmp/openstackcompute.log

# Enable and start nova services on compute node
RUN systemctl enable libvirtd.service openstack-nova-compute.service
# Not run here
#RUN systemctl start libvirtd.service openstack-nova-compute.service

# Enable and start neutron services on compute node
RUN systemctl enable neutron-linuxbridge-agent.service
# Not run here
#RUN systemctl start neutron-linuxbridge-agent.service
