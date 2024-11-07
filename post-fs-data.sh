#!/usr/bin/env sh
MODDIR="/data/adb/modules/bindhosts"


ls $MODDIR/system/etc/hosts || cat /system/etc/hosts > $MODDIR/system/etc/hosts
chcon -r u:object_r:system_file:s0 "$MODDIR/system/etc/hosts"
chmod 644 $MODDIR/system/etc/hosts

dmesg | grep "hosts_file_redirect" && {
	ls /data/adb/hosts || cat /system/etc/hosts > /data/adb/hosts
	chcon -r u:object_r:system_file:s0 "/data/adb/hosts"
	chmod 644 /data/adb/hosts
	touch $MODDIR/skip_mount
	touch $MODDIR/.hfr_found
}


# useless
echo "bindhosts: post-fs-data.sh - active ✅" >> /dev/kmsg

# EOF
