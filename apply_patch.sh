#!/bin/bash

restart_services() {
  systemctl restart pveproxy pvedaemon
}

#Install needed files
apt-get update && apt-get install -y patch

# Backup the original files that we are patching.
mkdir /root/patch-backup
cp /usr/share/pve-manager/js/pvemanagerlib.js /root/patch-backup/
cp /usr/share/perl5/PVE/Network/SDN/VnetPlugin.pm /root/patch-backup/

#Patch each file
patch -p1 /usr/share/pve-manager/js/pvemanagerlib.js /root/proxmox_orchestration_patch/pvemanagerlib-orchestration.patch
patch -p1 /usr/share/perl5/PVE/Network/SDN/VnetPlugin.pm /root/proxmox_orchestration_patch/VnetPlugin-orchestration.patch

md5sum /usr/share/pve-manager/js/pvemanagerlib.js
md5sum /usr/share/perl5/PVE/Network/SDN/VnetPlugin.pm

restart_services
echo "Done ✅  (pveproxy + pvedaemon restarted)"
echo "Tip: Hard-refresh the browser (Shift+Reload) to bust cached JS."
echo "Script execution completed."
