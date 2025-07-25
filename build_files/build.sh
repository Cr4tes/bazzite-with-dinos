#!/bin/bash

set -ouex pipefail

mkdir -p /var/roothome

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
dnf5 install -y gnome-shell-extension-dash-to-dock
    
dnf5 -y copr enable ublue-os/packages
dnf5 -y install bluefin-backgrounds 
dnf5 -y copr disable ublue-os/packages

# change renderer, to be moved
touch /etc/profile.d/10-renderer.sh
echo 'export GSK_RENDERER=ngl' > /etc/profile.d/10-renderer.sh

# Automatic wallpaper changing by month
HARDCODED_RPM_MONTH="12"
sed -i '/picture-uri/ s/file:\/\/\/usr\/share\/backgrounds\/convergence-dynamic.xml/file:\/\/\/usr\/share\/backgrounds\/bluefin\/12-bluefin.xml/' "/usr/share/glib-2.0/schemas/zz0-04-bazzite-desktop-silverblue-theme.gschema.override"
sed -i "/picture-uri/ s/${HARDCODED_RPM_MONTH}/$(date +%m)/" "/usr/share/glib-2.0/schemas/zz0-04-bazzite-desktop-silverblue-theme.gschema.override"
glib-compile-schemas /usr/share/glib-2.0/schemas

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable podman.socket
