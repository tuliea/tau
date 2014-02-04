#!/bin/sh

cd /exlibris/primo/p4_1/ng/primo/home/system/search/conf
EBSCO_USER="xxxx"
EBSCO_PW="xxxx"
EBSCO_URL="http://eit.ebscohost.com/Services/SearchService.asmx/Search"

for i in $(grep , thirdnode-config.xml | gawk '{dbs = substr($0,index($0,"<val>")+5,index(substr($0,index($0,"<val>")+5),"</val>")-1); gsub(/,/,"\\&db=",dbs); print dbs}'); do
	url=$EBSCO_URL"?prof="$EBSCO_USER"&pwd="$EBSCO_PW"&authType=&ipprof=&query=test&db="$i
	curl $url >& xx
	err=`grep Message xx | wc -l `
	echo "url: "$url >> xx
	if [ "$err" == "1" ]; then
		mailx -s "primo - One of these ebsco databases is failing "$i you@uni.edu < xx
	fi
rm xx

done
