#!/bin/bash
if [ -z "${1}" ]
then
    printf "ERROR: the ipl img was empty, please enter.\n"
    exit 1
fi

if [ -z "${2}" ]
then
    printf "ERROR: the kernel img was empty, please enter.\n"
    exit 1
fi

ipl=$1
kernel=$2
os_name=$3

if [ -z "${3}" ]
then
    printf "WARNNING: the os name was empty, \nwe set default value is sparrow-os and will create sparrow-os.img\n\n"
    os_name="sparrow-os"
fi

# Get current path of the bash file.
root_path=$( cd "$(dirname "${BASH_SOURCE[0]}")/../" ; pwd -P )
artifacts_path="${root_path}/artifacts"
os_path="${artifacts_path}/${os_name}.img"

printf "Create OS image, the image size is 1474560KB\n"
readonly OS_IMG_SIZE=1474560

# Get size of the ipl and kernel img files.
ipl_path="${root_path}/${ipl}"
ipl_size=$(wc -c $ipl_path | awk '{print  $1}')

kernel_path="${root_path}/${kernel}"
kernel_size=$(wc -c $kernel_path | awk '{print  $1}')

printf "%s ;size %s\n" "IPL imgae full path: ${ipl_path}" "${ipl_size}B"
printf "%s ;size %s\n" "Kernel imgae full path: ${kernel_path}" "${kernel_size}B"

remain_size=`expr $OS_IMG_SIZE - $ipl_size - $kernel_size`

if test -e $os_path
then
    $(rm $os_path)
fi

if [ $remain_size -lt 0 ]
then
    printf "ERROR: Total size of the ipl and kernel file is more than ${OS_IMG_SIZE}B\n"
    exit 1
fi

printf "Total size of the ipl and kernel file is less than or equle ${OS_IMG_SIZE}B\n"
$(cat $ipl_path $kernel_path > $os_path)

if [ $remain_size -gt 0 ]
then
    $(qemu-img resize -f raw $os_path $OS_IMG_SIZE > /dev/null)
fi

printf "the os image successfull created.\nPath: ${os_path}\n"
exit 0

