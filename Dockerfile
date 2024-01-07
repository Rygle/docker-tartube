# Pull base image.
FROM ghcr.io/linuxserver/baseimage-kasmvnc:debianbookworm

# Define working directory.
WORKDIR /tmp

# Define download URLs.
# ARG TARTUBE_VERSION=2.4.429
# ARG TARTUBE_URL=https://github.com/axcore/tartube/releases/download/v${TARTUBE_VERSION}/python3-tartube_${TARTUBE_VERSION}.deb
# ARG TARTUBE_URL=["curl -s https://api.github.com/repos/axcore/tartube/releases/latest \
# 		| grep -v STRICT | grep "browser_download_url.*deb" \
# 		| cut -d : -f 2,3 \
# 		| tr -d \""]

# install packages
ARG     DEBIAN_FRONTEND=noninteractive
RUN     sudo apt-get update -y
RUN     sudo apt-get upgrade -y
RUN     sudo apt-get -y --no-install-recommends install pkg-config
RUN     sudo apt-get -y --no-install-recommends install ffmpeg
RUN     sudo apt-get -y --no-install-recommends install python3-pip
RUN     sudo apt-get -y --no-install-recommends install python3-full
RUN     sudo apt-get -y --no-install-recommends install python3-feedparser
RUN     sudo apt-get -y --no-install-recommends install python3-requests
RUN     sudo apt-get -y --no-install-recommends install python3-matplotlib
RUN     sudo apt-get -y --no-install-recommends install python3-gi
RUN     sudo apt-get -y --no-install-recommends install python-gi-dev
RUN     sudo apt-get -y --no-install-recommends install gobject-introspection
RUN     sudo apt-get -y --no-install-recommends install python3-cairo
RUN     sudo apt-get -y --no-install-recommends install python3-gi-cairo
RUN     sudo apt-get -y --no-install-recommends install python3-cairocffi
RUN     sudo apt-get -y --no-install-recommends install gir1.2-gtk-3.0
RUN     sudo apt-get -y --no-install-recommends install libgtk-3-common
RUN     sudo apt-get -y --no-install-recommends install libgtk-3-0
RUN     sudo apt-get -y --no-install-recommends install aria2
RUN     sudo apt-get -y --no-install-recommends atomicparsley
RUN     sudo apt-get -y --no-install-recommends install pipx


# RUN     sudo pip install feedparser
# RUN     sudo pipx install PyGObject
# RUN     sudo pip install --include-deps matplotlib
RUN     sudo pipx install streamlink
# RUN     sudo pipx install aria2
RUN     sudo pipx install playsound
RUN     sudo pipx install yt-dlp
RUN     sudo pipx install tartube
RUN     sudo pipx install moviepy

RUN     sudo pipx completions
RUN     sudo pipx ensurepath

RUN     sudo pkg-config cairo

#	wget --output-document=/tmp/tartube.deb ${TARTUBE_URL} && \
#
#	wget -O /tmp/tartube.deb $["curl -s https://api.github.com/repos/axcore/tartube/releases/latest \
#		| grep -v STRICT | grep "browser_download_url.*deb" \
#		| cut -d : -f 2,3 \
#		| tr -d \""] && \
#	dpkg -i /tmp/tartube.deb && \

#	sudo apt-get -y --no-install-recommends install /tmp/tartube.deb
RUN     sudo apt-get -y autoremove
RUN     sudo apt-get -y clean
RUN     sudo rm -rf /var/lib/sudo apt/lists/*
RUN     sudo rm -rf /tmp/*

# Define variables.
# ENV	DOCKER_MODS=linuxserver/mods:universal-package-install \
# ENV	INSTALL_PACKAGES=wget|python3-gi|gir1.2-gtk-3.0|libgtk-3-common|libgtk-3-0 \
# ENV	INSTALL_PIP_PACKAGES=tartube|yt-dlp|moviepy|aria2|streamlink|AtomicParsley|matplotlib|feedparser|PyGObject
ENV     LANGUAGE=en_US:en
ENV     LC_ALL=en_US.UTF-8
ENV     APP_NAME="Tartube"
ENV     DISPLAY_WIDTH="1600"
ENV     DISPLAY_HEIGHT="900"
VOLUME ["/storage/"]
VOLUME ["/config/"]
EXPOSE 3000
ENTRYPOINT ["tartube"]
# ENTRYPOINT ["~/.local/bin/tartube"]
