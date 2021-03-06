# Sizeof Network stacks

This project determines the sizeof network stacks used in constrained environments. To make sure that the comparison data is fair, the network stacks are compiled using the same ARM cross-compiler and using similar CFLAGS/LDFLAGS.

This work was done to cross-verify the data in [draft-ietf-lwig-tcp-constrained-node-networks-04](https://tools.ietf.org/html/draft-ietf-lwig-tcp-constrained-node-networks-04). For understanding how the constrained tcp-stacks differ from each other, do read the draft.

There were two methods used to get the memory sizes for the desired modules:
1. Enable and then disable the relevant module (for example LWIP_TCP, or UIP_CONF_TCP) and get the difference in flash/ram.
2. Use size utility and the linker generated map files to evaluate the memory requirements of the relevant module (based on object files).

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

## LWIP sizeof network stack

## Configuration

| Config | Value |
|--------|-------|
| LWIP version | 2.1.2 |
| DEBUG | OFF |
| Compiler | arm-none-eabi-gcc |
| CFLAGS | -Os |
| MEM_SIZE | 1600 |
| MEMP_NUM_PBUF | 16 |
| MEMP_NUM_NETCONN | 32 |
| PBUF_POOL_SIZE | 8 |
| MEMP_NUM_TCP_SEG | 16 |
| MEMP_NUM_TCP_PCB_LISTEN | 4 |

### FULL LWIP with TCP=0

Text size=87060, Data size=25, BSS size=12816

### FULL LWIP with TCP=1

Text size=125124, Data size=33, BSS size=14492

### LWIP's TCP ONLY size

Text size=38064, Data size=8, BSS size=1676

[LWIP2.1.2 map file](lwip.map)

## Interested in reproducing the data?

Steps to reproduce:

1. Clone/Download the repo
2. run `./sizeof.sh`
3. `lwip.md` is created in lwip-arm folder
4. Contiki-NG related stats are printed in the output of ./sizeof.sh

(TODO: auto-create contiki-ng.md just like lwip.md)

