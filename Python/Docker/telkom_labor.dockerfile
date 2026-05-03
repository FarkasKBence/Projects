FROM kathara/frr

RUN apt-get update && \
    apt-get install -y isc-dhcp-server