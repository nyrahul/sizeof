#!/bin/bash

data=`grep "^\.data " bin/output.map | awk '{printf $3}'`
bss=`grep "^\.bss " bin/output.map | awk '{printf $3}'`
text=`grep "^\.text " bin/output.map | awk '{printf $3}'`
data=`printf "%d" $data`
bss=`printf "%d" $bss`
text=`printf "%d" $text`

echo "text=$text data=$data bss=$bss"
