#!/bin/bash

PKGDIR=packages
CNGPKG=contiki-ng.zip

make_contiki_ng()
{
    sed -i "s/#define.*UIP_CONF_TCP.*$/#define UIP_CONF_TCP $1/g" project-conf.h
    echo "Compiling with TCP=$1 ..."
    make TARGET=cc2538dk &>/dev/null
    [[ $? -ne 0 ]] && echo "contiki_ng: make failed" && exit 3
    text=`size border-router.cc2538dk | tail -1 | awk '{print $1}'`
    data=`size border-router.cc2538dk | tail -1 | awk '{print $2}'`
    bss=`size border-router.cc2538dk | tail -1 | awk '{print $3}'`
    echo "contiki-ng: TCP=$1 sizeof(border-router.cc2538dk)"
    size border-router.cc2538dk
}

main()
{
    [[ ! -d "contiki-ng-develop" ]] && unzip $CNGPKG
    cd contiki-ng-develop/examples/rpl-border-router

    make_contiki_ng 0
    wotcp_text=$text
    wotcp_data=$data
    wotcp_bss=$bss

    make_contiki_ng 1

    diff_text=`echo "$text - $wotcp_text" | bc -q`
    diff_data=`echo "$data - $wotcp_data" | bc -q`
    diff_bss=`echo "$bss - $wotcp_bss" | bc -q`

    echo "Contiki-NG: sizeof(TCP_ONLY) text=$diff_text, data=$diff_data, bss=$diff_bss"

    echo ;
    echo "Contiki-NG: with TCP/IP6/ICMP6 (no 6lo)"
    size -t `cat tcp_ip_related.txt`
}

#Processing starts here
main

