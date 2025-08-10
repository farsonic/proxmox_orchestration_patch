#!/bin/bash

restart_services() {
  systemctl restart pveproxy pvedaemon
}

# Restore the original files that we are patching.

cp /root/patch-backup/pvemanagerlib.js /usr/share/pve-manager/js/pvemanagerlib.js
cp /root/patch-backup/VnetPlugin.pm /usr/share/perl5/PVE/Network/SDN/VnetPlugin.pm
cp /usr/share/perl5/PVE/Network/SDN/VnetPlugin.pm /root/patch-backup/


restart_services
echo "Done ✅  (pveproxy + pvedaemon restarted)"
echo "Tip: Hard-refresh the browser (Shift+Reload) to bust cached JS."
echo "Script execution completed."
