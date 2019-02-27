# LWIP sizeof network stack

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

## FULL LWIP with TCP=0

Text size=87060, Data size=25, BSS size=12816

## FULL LWIP with TCP=1

Text size=125124, Data size=33, BSS size=14492

## LWIP's TCP ONLY size

Text size=38064, Data size=8, BSS size=1676

