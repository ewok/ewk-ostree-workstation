#!/usr/bin/env bash
set -xeuo pipefail

## Enable SysRQ
echo 'kernel.sysrq = 1' > /usr/lib/sysctl.d/90-sysrq.conf
#
# power saving
echo 'blacklist e1000e' > /usr/lib/modprobe.d/blacklist-local.conf

ln -sfn /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf

### enable other units
systemctl enable getty@tty1.service
systemctl enable systemd-timesyncd.service
systemctl enable systemd-resolved.service
systemctl enable sshd.service

# update for Red Hat certificate
ln -s /etc/pki/ca-trust/source/anchors/2015-RH-IT-Root-CA.pem /etc/pki/tls/certs/2015-RH-IT-Root-CA.pem
update-ca-trust
