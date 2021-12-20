#need base openstack glance and qemu-img
#FROM openstack
FROM osbase
ADD compress.sh /
CMD mkdir /pub
ENV BASE '/pub'
ENV DISTRO centos
ENV COMPAT 1.1
ENV VISIBILITY '--private'
ENV IMG_ORIG_USER root
ENV INPUT_FORMAT qcow2
ENV OUTPUT_FORMAT qcow2

#ENTRYPOINT sh 
CMD ./compress.sh 
