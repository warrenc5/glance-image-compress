#!/bin/bash -x 

if [ -f /openrc.sh ] ; then
  echo 'sourcing openrc.sh'
  . /openrc.sh
fi 

#BASE=/pub
OLD=$BASE/in.$INPUT_FORMAT
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

echo "downloading."
glance image-download --progress --file $OLD $SRC
echo "downloaded."

ls -lah $DEST

echo "converting."
qemu-img convert -p -c -f $INPUT_FORMAT -O $OUTPUT_FORMAT -o compat=$COMPAT $OLD $NEW

echo "converted."
ls -lah $NEW

echo "uploading."
openstack image create --disk-format $OUTPUT_FORMAT --container-format bare --file $NEW "$NAME" "--private" --property distribution=$DISTRO --property hw_disk_bus=scsi --property hw_scsi_model=virtio-scsi --property hw_qemu_guest_agent=yes --property image_original_user=$IMG_ORIG_USER

echo "done."
