# Pull base image.
FROM ghcr.io/linuxserver/baseimage-kasmvnc:debianbookworm

# Define working directory.
WORKDIR /tmp

# Define download URLs.
ARG TARTUBE_VERSION=2.4.429
ARG TARTUBE_URL=https://github.com/axcore/tartube/releases/download/v${TARTUBE_VERSION}/python3-tartube_${TARTUBE_VERSION}.deb
# ARG	TARTUBE_URL=["curl -s https://api.github.com/repos/axcore/tartube/releases/latest \
# 		| grep -v STRICT | grep "browser_download_url.*deb" \
# 		| cut -d : -f 2,3 \
# 		| tr -d \""]

# install packages
# RUN   rm -rf /etc/apt/sources.list*
# RUN 	echo 'deb http://cdn-fastly.deb.debian.org/debian bookworm main contrib non-free' > /etc/apt/sources.list
# RUN 	echo 'deb-src http://cdn-fastly.deb.debian.org/debian bookworm main contrib non-free' >> /etc/apt/sources.list
# 
# RUN 	echo 'deb http://cdn-fastly.deb.debian.org/debian-security/ bookworm-security main contrib non-free' >> /etc/apt/sources.list
# RUN 	echo 'deb-src http://cdn-fastly.deb.debian.org/debian-security/ bookworm-security main contrib non-free' >> /etc/apt/sources.list
# 
# RUN 	echo 'deb http://cdn-fastly.deb.debian.org/debian bookworm-updates main contrib non-free' >> /etc/apt/sources.list
# RUN 	echo 'deb-src http://cdn-fastly.deb.debian.org/debian bookworm-updates main contrib non-free' >> /etc/apt/sources.list

RUN     apt-get update -y && \
# RUN	apt-get update -y

     apt-get upgrade -y && \
# RUN	apt-get upgrade -y

     apt-get -y --no-install-recommends install wget && \
# RUN	apt-get -y --no-install-recommends install wget

     wget --output-document=/tmp/tartube.deb ${TARTUBE_URL} && \
# RUN	wget --output-document=/tmp/tartube.deb ${TARTUBE_URL}

#	wget -O /tmp/tartube.deb $["curl -s https://api.github.com/repos/axcore/tartube/releases/latest \
#		| grep -v STRICT | grep "browser_download_url.*deb" \
#		| cut -d : -f 2,3 \
#		| tr -d \""] && \
#	dpkg -i /tmp/tartube.deb && \

     apt-get -y --no-install-recommends install /tmp/tartube.deb && \
# RUN	apt-get -y --no-install-recommends install /tmp/tartube.deb

     apt-get -y autoremove && \
# RUN	apt-get -y autoremove

     apt-get -y clean && \
# RUN	apt-get -y clean


     rm -rf /var/lib/apt/lists/*  && \
# RUN	rm -rf /var/lib/apt/lists/*
     rm -rf /tmp/*RUN	rm -rf /tmp/*

# Define variables.
ENV	DOCKER_MODS=linuxserver/mods:universal-package-install \
	INSTALL_PACKAGES=wget|python3-gi|gir1.2-gtk-3.0|libgtk-3-common|libgtk-3-0 \
	INSTALL_PIP_PACKAGES=yt-dlp|moviepy|aria2|streamlink|AtomicParsley|matplotlib|feedparser \
	LANGUAGE=en_US:en \
	LC_ALL=en_US.UTF-8 \
	APP_NAME="Tartube" \
	DISPLAY_WIDTH="1600" \
	DISPLAY_HEIGHT="900"
VOLUME ["/storage/"]
VOLUME ["/config/"]
EXPOSE 3000
ENTRYPOINT ["tartube"]
#ENTRYPOINT ["~/.local/bin/tartube"]
