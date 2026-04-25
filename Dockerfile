FROM lsiobase/ubuntu:jammy

ARG DEBIAN_FRONTEND=noninteractive

ENV \
        DHCPD_IF= \
	DHCP_V6= \
	TZ=UTC

# Set up
RUN \
echo "*** install utilities needed ****" && \
	apt-get update && \
	apt-get -y install isc-dhcp-server \
                inotify-tools && \
	echo "**** clean up ****" && \
	apt-get -y clean && \
	apt-get -y autoremove && \
	rm -rf /var/lib/apt/lists/*

# Add configuration files
COPY root /

EXPOSE 69/udp
EXPOSE 647/tcp
EXPOSE 547/udp

VOLUME [ "/config", "/data" ]

