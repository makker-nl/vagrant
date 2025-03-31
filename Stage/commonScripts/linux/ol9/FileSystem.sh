#!/bin/bash
# Taken from  https://oracle-base.com/articles/linux/linux-logical-volume-management
# and https://www.golinuxcloud.com/lvcreate-command-in-linux/#Are_you_new_to_LVM_and_still_learning_how_it_works
# and for xfs: https://www.linuxbuzz.com/create-xfs-file-system-in-linux/
export VOL_GROUP_NAME="DataVolGroup"
export VOL_NAME="DataVol"
export MOUNT_POINT="/app"

function create_volume(){
  local storage_device="$1"
  local volume_group_name="$2"
  local volume_name="$3"
  echo "Initialize $storage_device as a physical volume "
  sudo pvcreate $storage_device
  echo "Create volume group $volume_group_name on $storage_device" 
  sudo vgcreate $volume_group_name $storage_device
  echo "Volume group $volume_group_name:"
  sudo vgdisplay $volume_group_name
  echo "Create volume $volume_name on volume group $volume_group_name" 
  sudo lvcreate -l 100%FREE -n $volume_name $volume_group_name
}

function create_fs(){
  local volume_group_name="$1"
  local volume_name="$2"
  local mount_point="$3"
  echo "Create XFS filesystem on $volume_group_name/$volume_name"
  sudo mkfs.xfs /dev/$volume_group_name/$volume_name -f
  echo "Create folder for mountpoint $mount_point"
  sudo mkdir -p $mount_point
  echo "Add /dev/$volume_group_name/$volume_name mounted to $mount_point to fstab"
  sudo sh -c "echo \"/dev/$volume_group_name/$volume_name       $mount_point                    xfs     defaults        0 0\" >> /etc/fstab"
  sudo systemctl daemon-reload
  sudo mount /app
}

function main(){
  echo "Get unused disk"
  local sd_unused=""
  for sd in /dev/sd?; do
    echo "Storage device -> $sd"
    partitions=$(sudo pvdisplay -C -o pv_name,vg_name |grep $sd)
    if [ "$partitions" == "" ]; then
      echo "Storage device $sd does not have partitions"
      sd_unused=$sd
    else
      echo "Storage device $sd has partitions: $partitions"
    fi
  done
  if [ "$sd_unused" != "" ]; then
    create_volume $sd_unused $VOL_GROUP_NAME $VOL_NAME
    create_fs  $VOL_GROUP_NAME $VOL_NAME $MOUNT_POINT
  else
    echo "No unused storage device found."
  fi
}

main "$@"