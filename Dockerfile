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

RUN echo "/proc/sys/net/bridge/bridge-nf-call-iptables value:" > /tmp/openstackcompute.log
RUN cat /proc/sys/net/bridge/bridge-nf-call-iptables >> /tmp/openstackcompute.log

RUN echo "/proc/sys/net/bridge/bridge-nf-call-ip6tables value:" >> /tmp/openstackcompute.log
RUN cat /proc/sys/net/bridge/bridge-nf-call-ip6tables >> /tmp/openstackcompute.log
