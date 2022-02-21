FROM lsiobase/ubuntu:focal

ARG DEBIAN_FRONTEND=noninteractive

ENV \
        DHCPD_IF= \
	TZ=UTC

# Set up
RUN \
echo "*** install utilities needed ****" && \
	apt update && \
        apt upgrade -y && \
	apt -y install isc-dhcp-server \
                inotify-tools && \
	rm -rf /var/lib/apt/lists/*

# Add configuration files
COPY root /

EXPOSE 69/udp
EXPOSE 647/tcp

VOLUME [ "/config", "/data" ]

