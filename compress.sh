#!/bin/bash -x 

if [ -f /openrc.sh ] ; then
  echo 'sourcing openrc.sh'
  . /openrc.sh
  GLANCE=1
fi 

BASE=/pub
#OLD=$BASE/$INFILE.$INPUT_FORMAT
OLD=$BASE/$INFILE
NEW=$BASE/out.$OUTPUT_FORMAT
echo ${SRC} $NAME

#SRC=cc3a6568-a9c9-6666-b340-9f6192421489
#NAME="My New Compressed Disk Image"
#DISTRO="centos"
#COMPAT=1.1
#VISIBILITY="--private"
#IMG_ORIG_USER="root"
#INPUT_FORMAT=qcow2
cd $BASE

if [ ! -z "$GLANCE" ] ; then
echo "downloading."
glance image-download --progress --file $OLD $SRC
echo "downloaded."

if [ ! -f $OLD ] ; then echo "download failed" && exit 1 
ls -lah $DEST
fi 
else 

echo "skipping download - no glance info"

fi 


echo "converting."
qemu-img convert -p -c -f $INPUT_FORMAT -O $OUTPUT_FORMAT -o compat=$COMPAT $OLD $NEW

echo "converted."
ls -lah $NEW

if [ ! -f $NEW ] ; then echo "compress failed" && exit 1 

if [ ! -z "$GLANCE" ] ; then

echo "uploading."
openstack image create --disk-format $OUTPUT_FORMAT --container-format bare --file $NEW "$NAME" "--private" --property distribution=$DISTRO --property hw_disk_bus=scsi --property hw_scsi_model=virtio-scsi --property hw_qemu_guest_agent=yes --property image_original_user=$IMG_ORIG_USER

else 

echo "skipping upload - no glance info"

fi 

echo "done."
