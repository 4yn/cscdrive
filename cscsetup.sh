#!/bin/bash

# Check logfile and terminate if exists

if [ -f /var/log/cscsetup.lockfile ]; then
    echo "Setup already proceeded, delete lockfile at /var/log/cscsetup.lockfile to redo"
    return 0
fi

touch /var/log/cscsetup.lockfile

# Hostname

echo "Please enter new hostname:"

read tmphostname
hostname $tmphostname

echo -e "127.0.0.1\tlocalhost\n127.0.0.1\t${tmphostname}\n" > /etc/hosts

# Images

wget -O /usr/share/backgrounds/warty-final-ubuntu.png https://raw.githubusercontent.com/4yn/cscdrive/master/bkg.png

# Users

printf "[SeatDefaults]\nallow-guest=false\n" > /etc/lightdm/lightdm.conf.d/50-no-guest.conf

# apt Repositories

wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" > /etc/apt/sources.list.d/sublime-text.list

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - 
echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list

add-apt-repository ppa:noobslab/themes -y
add-apt-repository ppa:noobslab/icons -y

# Packages + Node Deps

apt update

apt install synaptic sublime-text python-software-properties flatabulous-theme ultra-flat-icons google-chrome-stable broadcom-sta-common broadcom-sta-dkms broadcom-sta-source firmware-b43-installer vlc curl -y

# Bloat removal

apt remove account-plugin-aim account-plugin-facebook account-plugin-flickr account-plugin-jabber account-plugin-salut account-plugin-twitter account-plugin-yahoo aisleriot brltty colord deja-dup deja-dup-backend-gvfs duplicity empathy empathy-common evolution-data-server-online-accounts example-content gnome-accessibility-themes gnome-contacts gnome-mahjongg gnome-mines gnome-orca gnome-screensaver gnome-sudoku gnome-video-effects gnomine libreoffice-avmedia-backend-gstreamer libreoffice-base-core libreoffice-calc libreoffice-common libreoffice-core libreoffice-draw libreoffice-gnome libreoffice-gtk libreoffice-impress libreoffice-math libreoffice-ogltrans libreoffice-pdfimport libreoffice-presentation-minimizer libreoffice-style-galaxy libreoffice-style-human libreoffice-writer libsane libsane-common mcp-account-manager-uoa python3-uno rhythmbox rhythmbox-plugins rhythmbox-plugin-zeitgeist sane-utils shotwell shotwell-common thunderbird thunderbird-gnome-support totem totem-common totem-plugins unity-scope-chromiumbookmarks unity-scope-colourlovers unity-scope-devhelp unity-scope-firefoxbookmarks unity-scope-gdrive unity-scope-manpages unity-scope-musicstores unity-scope-openclipart unity-scope-texdoc unity-scope-tomboy unity-scope-video-remote unity-scope-virtualbox unity-scope-yelp unity-scope-zotero -y

# Node

curl -sL https://deb.nodesource.com/setup_6.x | bash -

apt install nodejs npm -y

# Total Update

apt upgrade

# Set UI

gsettings set org.gnome.desktop.interface gtk-theme Flatabulous
gsettings set org.gnome.desktop.interface icon-theme Ultra-Flat

gsettings set com.canonical.Unity.Launcher favorites "['application://org.gnome.Nautilus.desktop', 'application://unity-control-center.desktop', 'application://gnome-terminal.desktop', 'application://firefox.desktop', 'application://google-chrome.desktop', 'application://sublime_text.desktop', 'unity://running-apps', 'unity://expo-icon', 'unity://devices']
"


