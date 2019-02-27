#!/bin/bash

LWIPPKG=lwip-2.1.2.zip
CONTPKG=contrib-2.1.0.zip
MD=lwip.md

get_cfg()
{
    line=`grep "^#.*define.*$1" lwipopts.h`
    [[ $? -ne 0 ]] && cfg="$1 NOTFOUND" && return
    cfg=`echo "$line" | awk '{print $3}'`
}

md_prn_cfg()
{
    get_cfg "$1"
    echo "| $1 | $cfg |"
}

wr_lwip_hdr()
{
    cat <<HDR
# LWIP sizeof network stack

## Configuration

| Config | Value |
|--------|-------|
HDR
    echo "| LWIP version | 2.1.2 |"
    echo "| DEBUG | OFF |"
    echo "| Compiler | arm-none-eabi-gcc |"
    echo "| CFLAGS | -Os |"
    md_prn_cfg "MEM_SIZE"
    md_prn_cfg "MEMP_NUM_PBUF"
    md_prn_cfg "MEMP_NUM_NETCONN"
    md_prn_cfg "PBUF_POOL_SIZE"
    md_prn_cfg "MEMP_NUM_TCP_SEG"
    md_prn_cfg "MEMP_NUM_TCP_PCB_LISTEN"
    echo ;
}

make_lwip()
{
    sed -i "s/#define.*LWIP_TCP.*$/#define LWIP_TCP $1/g" lwipopts.h
    echo "Compiling with TCP=$1 ..."
    make &>t.txt
    [[ $? -ne 0 ]] && echo "lwip: make failed" && exit 3
    str=`grep "^text=.*data=.*bss=.*" t.txt | sed 's/=/ /g'`
    rm t.txt
    text=`echo $str | awk '{print $2}'`
    data=`echo $str | awk '{print $4}'`
    bss=`echo $str | awk '{print $6}'`
    echo "lwip2.1.2: TCP=$1 text=$text, data=$data, bss=$bss"
    cat >>$MD <<EOF
## FULL LWIP with TCP=$1

Text size=$text, Data size=$data, BSS size=$bss

EOF
}

main()
{
    [[ ! -d "lwip" ]] && unzip $LWIPPKG && mv ${LWIPPKG/.zip/} lwip
    [[ ! -d "contrib" ]] && unzip $CONTPKG && mv ${CONTPKG/.zip/} contrib

    cd lwip_arm
    wr_lwip_hdr > $MD

    make_lwip 0
    wotcp_text=$text
    wotcp_data=$data
    wotcp_bss=$bss

    make_lwip 1

    diff_text=`echo "$text - $wotcp_text" | bc -q`
    diff_data=`echo "$data - $wotcp_data" | bc -q`
    diff_bss=`echo "$bss - $wotcp_bss" | bc -q`

    cp bin/output.map ../../lwip.map

    echo "LWIP: sizeof(TCP_ONLY) text=$diff_text, data=$diff_data, bss=$diff_bss"
    cat >>$MD <<EOF
## LWIP's TCP ONLY size

Text size=$diff_text, Data size=$diff_data, BSS size=$diff_bss

EOF
}

#Processing starts here
main

