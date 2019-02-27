#!/bin/bash

PKGDIR=packages

chk_cmd()
{
    hash $1
    [[ $? -ne 0 ]] && echo "$1 command not found" && exit 2
}

chk_dep()
{
    chk_cmd unzip       # for unzipping packages
    chk_cmd srec_cat    # for cc2538dk platform compilation by contiki-ng
    chk_cmd arm-none-eabi-gcc   # for cross-compilation for cc2538dk
    chk_cmd cmake   # for lwip compilation
}

main()
{
    cd $PKGDIR
    ./sz_contiki-ng.sh
}

#Processing starts here
chk_dep
main
