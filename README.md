# docker-dhcpd
A container running [ISC DHCP Server](https://www.isc.org/dhcp/).

# Usage

## docker

```
docker create \
  --name=dhcpd \
  -e TZ=Europe/London \
  -i DHCP_IF=eth0 \
  --net host \
  --ports 69/udp \
  --restart unless-stopped \
  -v ./config:/config \
  -v ./data:/data \
  jchonig/dhcpd
```

### docker-compose

Compatible with docker-compose v2 schemas.

```
---
version: "2"
services:
  monit:
    image: jchonig/dhcpd
    container_name: dhcpd
    environment:
      - TZ=Europe/London
	  - DHCP_IF=eth0
    volumes:
      - </path/to/appdata/config>:/config
	  - dhcpd_data:/data
	network_mode: host
    ports:
      - 69
    restart: unless-stopped

...

volumes:
  dhcpd_data
```

# Parameters

## Ports (--expose)

| Port    | Function            |
| ------  | --------            |
| 69/udp  | DHCPD port          |
| 647/tcp | DHCPD failover port |
|         |                     |

## Environment Variables (-e)

| Env       | Function                              |
|-----------|---------------------------------------|
| PUID=1000 | for UserID                            |
| PGID=1000 | for GroupID                           |
| TZ=UTC    | Specify a timezone to use, e.g. UTC   |
| DHCP_IF=  | Default interface for isc-dhcp-server |
|           |                                       |

## Volume Mappings (-v)

| Volume  | Function                                     |
|---------|----------------------------------------------|
| /config | All the config files reside here             |
| /data   | Persistent volume containing the leases file |


# Application Setup

  * Environment variables can also be passed in a file named `env` in
    the `config` directory. This file is sourced by the shell.
  * /config will be monitored for changes.  Then these occur, the
    dhcp-server daemon will be restarted.
