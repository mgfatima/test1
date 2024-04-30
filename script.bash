#!/bin/bash
source=$1
dist=$2

find $source -type f > /tmp/tmp.txt
num=$(cat /tmp/tmp.txt | wc -l)
for i in $(seq 1 $num)
do
str=$(sed -n $i'p' /tmp/tmp.txt)
namefile=$(echo $str | sed 's/.*\///')
if ! [ -f "$dist/$namefile" ]; then
cp -v "${str}" "${dist}${namefile}"
else
namefile_1=$(echo $str | sed 's/.*\///')
if [[ ${namefile_1:1} == *"."* ]]; then namefile_2=$(echo $namefile_1 | sed 's/.*\.//'); namefile_1=$(echo $namefile_1 | sed 's/\..*//'); else namefile_2=""; fi
if [ -z ${namefile_2} ]; then namefile=$namefile_1"_"$(date "+%s%N"); else namefile=$namefile_1"_"$(date "+%s%N")"."$namefile_2; fi
cp -v "${str}" "${dist}${namefile}"
fi
sleep 0.1
done
rm /tmp/tmp.txt
