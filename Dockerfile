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
RUN     apt-get update -y
RUN     apt-get upgrade -y
RUN     apt-get -y --no-install-recommends install pkg-config
RUN     apt-get -y --no-install-recommends install ffmpeg
RUN     apt-get -y --no-install-recommends install python3-pip
RUN     apt-get -y --no-install-recommends install python3-gobject
RUN     apt-get -y --no-install-recommends install python3-requests
RUN     apt-get -y --no-install-recommends install python3-moviepy
RUN     apt-get -y --no-install-recommends install python3-gi
RUN     apt-get -y --no-install-recommends install python3-cairo
RUN     apt-get -y --no-install-recommends install python3-gi-cairo
RUN     apt-get -y --no-install-recommends install python3-cairocffi
RUN     apt-get -y --no-install-recommends install gir1.2-gtk-3.0
RUN     apt-get -y --no-install-recommends install libgtk-3-common
RUN     apt-get -y --no-install-recommends install libgtk-3-0
RUN     apt-get -y --no-install-recommends install aria2

RUN     pip3 install feedparser
RUN     pip3 install PyGObject
RUN     pip3 install matplotlib
RUN     pip3 install AtomicParsley
RUN     pip3 install streamlink
RUN     pip3 install aria2
RUN     pip3 install playsound
RUN     pip3 install yt-dlp
RUN     pip3 install tartube
RUN     pkg-config cairo
#	wget --output-document=/tmp/tartube.deb ${TARTUBE_URL} && \
#
#	wget -O /tmp/tartube.deb $["curl -s https://api.github.com/repos/axcore/tartube/releases/latest \
#		| grep -v STRICT | grep "browser_download_url.*deb" \
#		| cut -d : -f 2,3 \
#		| tr -d \""] && \
#	dpkg -i /tmp/tartube.deb && \

#	apt-get -y --no-install-recommends install /tmp/tartube.deb
RUN     apt-get -y autoremove
RUN     apt-get -y clean
RUN     rm -rf /var/lib/apt/lists/*
RUN     rm -rf /tmp/*

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
