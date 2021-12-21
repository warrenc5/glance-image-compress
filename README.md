when you have a large disk image in the cloud but want to download it in the fastest way.

this utility will download a disk image and compress it in qcow2 format and upload it back to glance - if this can all happen on the remote cloud environment then no local bandwidth is consumed. 

The actual dimensions of the disk doesn't change - just the distribution size.

the download uses glance and the compression uses qemu-img which starts a vm. 

I couldn't find a way to stream the image through the convertor so you have to wait for the entire download to finish before beginning compression.

it uses a /pub volume which must be big enough to hold the input file and the output file at the same time

it uses compose to mount volumes for output 
it uses the openstack environment script if mounted at /openrc.sh if it exists
it is configurable through environment variables

usage 

how to run your docker compose on the cloud depending on your provider.

docker-compose build 
docker-compose run convert
