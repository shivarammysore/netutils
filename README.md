tcpdump on Docker
=================

This simple image runs a [tcpdump] and writes dumps to the volume `/data`.
It will keep at max 10x 1GB files and overwrite the oldest one.

View help and version

    $ docker run --rm shivarammysore/tcpdump --help

To capture on the hosts network interfaces, you need to run the
container by using the host networking mode:

    $ docker run --net=host shivarammysore/tcpdump

To specify filters or interface, you can use this image as you would
use `tcpdump`:

    ## Capture from a specific interface and port
    $ docker run --net=host shivarammysore/tcpdump -i eth2 port 80

    ## Capture only N number of packets - here 6 packets will be captured
    $ docker run --net=host shivarammysore/tcpdump -c 5 -i eth2

    ## Print Captured Packets in ASCII
    $ docker run --net=host shivarammysore/tcpdump -A -i eth2

    ## Display Available Interfaces
    $ docker run --net=host shivarammysore/tcpdump -D

    ## Display Captured Packets in HEX and ASCII
    $ docker run --net=host shivarammysore/tcpdump -XX -i eth2

    ## Capture IP address Packets
    $ docker run --net=host shivarammysore/tcpdump -n -i eth2

    ## Capture only TCP Packets.
    $ docker run --net=host shivarammysore/tcpdump -i eth2 tcp

    ## Capture Packets from source IP
    $ docker run --net=host shivarammysore/tcpdump -i eth2 src 192.168.0.2

    ## Capture Packets from Destination IP
    $ docker run --net=host shivarammysore/tcpdump -i eth2 dst 192.168.0.2


If you want storage to happen on your host:
(the important part is to mount the volume using `docker -v`, and to write data in that volume using `tcpdump -w`)

    $ docker run --net=host -v $PWD:/data shivarammysore/tcpdump -i any -w /data/dump.pcap "icmp"

To analyze the stream live remotely from wireshark:
(don't forget to filter out traffic on port 22)

    $ ssh root@remote-host "docker run --rm --net=host shivarammysore/tcpdump -i any -w - not port 22 2>/dev/null" | wireshark -k -i -

Examine the traffic of Docker container `foo` with Wireshark

    $ docker run --rm --net=container:foo shivarammysore/tcpdump -i any --immediate-mode -w - | wireshark -k -i -


References
==========

1. tcpdump: http://www.tcpdump.org/
2. CoRfr: https://github.com/CoRfr/tcpdump-docker

