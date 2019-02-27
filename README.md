# Sizeof Network stacks

## Contiki-NG

Sizeof(TCP\_ONLY) stack without IP6/ICMP6 and packet buffers. This was calculated by compiling ```examples/rpl-border-router``` with and without TCP support and getting the difference size.

* Contiki-NG: sizeof(TCP\_ONLY) text=3112, data=0, bss=596

Sizeof(TCP+IP6+ICMP6+PacketBuffers):

### Contiki-NG: with TCP/IP6/ICMP6 (no 6lo)

|  text	|  data	|   bss	 |  dec	 |  hex|filename |
|-------|-------|--------|-------|-----|-------------------------------------|
|   172	|     0	|     0	 |  172	 |   ac|build/cc2538dk/obj/memb.o |
|    86	|     0	|     0	 |   86	 |   56|build/cc2538dk/obj/net-debug.o |
|   128	|     0	|     4	 |  132	 |   84|build/cc2538dk/obj/netstack.o |
|   558	|     0	|   133	 |  691	 |  2b3|build/cc2538dk/obj/packetbuf.o |
|  1249	|    16	|   180	 | 1445	 |  5a5|build/cc2538dk/obj/tcpip.o |
|  1107	|    16	|     5	 | 1128	 |  468|build/cc2538dk/obj/tcp-socket.o |
|  4714	|     0	|     9	 | 4723	 | 1273|build/cc2538dk/obj/uip6.o |
|   456	|     0	|    24	 |  480	 |  1e0|build/cc2538dk/obj/uipbuf.o |
|   820	|    24	|    24	 |  868	 |  364|build/cc2538dk/obj/uip-icmp6.o |
|   146	|    12	|  2650	 | 2808	 |  af8|build/cc2538dk/obj/uip-packetqueue.o |
|**9436**	|**68**|**3029**|**12533**|**30f5**|**(TOTALS)**|

