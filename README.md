# Sizeof Network stacks

## Contiki-NG

Platform used CC2538DK, cross-compiling on linux.

Sizeof(TCP\_ONLY) stack without IP6/ICMP6 and packet buffers. This was calculated by compiling ```examples/rpl-border-router``` with and without TCP support and getting the difference in size.

> Contiki-NG: sizeof(TCP\_ONLY) text=3112, data=0, bss=596

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

### Contiki-NG: sizeof(RPL-Non-Storing-MOP-only)

|  text	|  data	|   bss	 |  dec	 |  hex|filename |
|-------|-------|--------|-------|-----|-------------------------------------|
|  2091	|     0	|     0	 | 2091	 |  82b|build/cc2538dk/obj/rpl-dag.o |
|   272	|     0	|    17	 |  289	 |  121|build/cc2538dk/obj/rpl-dag-root.o |
|  1244	|     0	|     0	 | 1244	 |  4dc|build/cc2538dk/obj/rpl-ext-header.o |
|  1838	|    48	|     0	 | 1886	 |  75e|build/cc2538dk/obj/rpl-icmp6.o |
|   340	|    36	|     0	 |  376	 |  178|build/cc2538dk/obj/rpl-mrhof.o |
|   196	|     0	|    10	 |  206	 |   ce|build/cc2538dk/obj/rpl-nbr-policy.o |
|  1210	|    20	|   128	 | 1358	 |  54e|build/cc2538dk/obj/rpl-neighbor.o |
|   697	|     0	|     1	 |  698	 |  2ba|build/cc2538dk/obj/rpl.o |
|   306	|    36	|     0	 |  342	 |  156|build/cc2538dk/obj/rpl-of0.o |
|  1458	|     0	|    64	 | 1522	 |  5f2|build/cc2538dk/obj/rpl-timers.o |
|**9652**|**140**|**220**|**10012**|**271c**|**(TOTALS)**|

[Contiki-ng full report](contiki-ng-full.md)
