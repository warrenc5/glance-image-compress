#need base openstack glance and qemu-img
FROM debian:stable-slim
USER root
RUN apt-get update
RUN apt-get -y install --no-install-recommends qemu-utils python3-openstackclient python3-glanceclient bash 
ADD compress.sh /
RUN mkdir /pub
ENV BASE '/pub'
ENV DISTRO centos
ENV COMPAT 1.1
ENV VISIBILITY '--private'
ENV IMG_ORIG_USER root
ENV INPUT_FORMAT qcow2
ENV OUTPUT_FORMAT qcow2

WORKDIR /
#ENTRYPOINT /bin/bash
CMD /bin/bash -x -c ./compress.sh 
