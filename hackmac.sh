#!/bin/bash

OPATH=`dirname $0`
if [ -L $0 ]
then
	OSCRIPT=`readlink $0`
	OPATH=`dirname $OSCRIPT`
fi

if [ "$1" == "" ]
then
    echo No MAC provided as parameter
    exit 1
fi

MAC=$1

VALID=0
HEX='[0-9abcdef]'
SEP='[-.: ]'

if [ `echo $MAC | egrep -i "^${HEX}{6}${SEP}${HEX}{6}\$"` ]
then
    VALID=1
    NMAC=`echo $MAC|sed 's/\(..\)\(..\)\(..\).\(..\)\(..\)\(..\)/\1-\2-\3-\4-\5-\6/'| tr '[a-z]' '[A-Z]'`
fi

if [ `echo $MAC | egrep -i "^${HEX}{4}${SEP}${HEX}{4}${SEP}${HEX}{4}\$"` ]
then
    VALID=1
    NMAC=`echo $MAC|sed 's/\(..\)\(..\).\(..\)\(..\).\(..\)\(..\)/\1-\2-\3-\4-\5-\6/'| tr '[a-z]' '[A-Z]'`
fi

if [ `echo $MAC | egrep -i "^${HEX}{2}${SEP}${HEX}{2}${SEP}${HEX}{2}${SEP}${HEX}{2}${SEP}${HEX}{2}${SEP}${HEX}{2}\$"` ]
then
    VALID=1
    NMAC=`echo $MAC|sed 's/\(..\).\(..\).\(..\).\(..\).\(..\).\(..\)/\1-\2-\3-\4-\5-\6/'| tr '[a-z]' '[A-Z]'`
fi

if [ $VALID != 1 ]
then
    echo No valid MAC detected
    exit 1
fi

echo Normalized MAC: $NMAC

VEND=`echo $NMAC | sed 's/^\(..\)-\(..\)-\(..\).*/\1-\2-\3/'`

echo Vendor $VEND

grep -A 5 $VEND ${OPATH}/oui.txt
if [ "$?" -ne "0" ]
then
    echo "Could not find a vendor"
fi

COUNT=1

#for j in 1 2
#do
    echo "$COUNT) $NMAC"
	COUNT=$[ $COUNT + 1 ]
    for i in . :
    do
        echo "$COUNT) $NMAC" | sed "s/-/$i/g"
		COUNT=$[ $COUNT + 1 ]
    done
    NMAC=`echo $NMAC | tr '[A-Z]' '[a-z]'`
#done

NMAC=`echo $NMAC |sed 's/\(..\).\(..\).\(..\).\(..\).\(..\).\(..\)/\1\2-\3\4-\5\6/'`

#for j in 1 2
#do
    echo "$COUNT) $NMAC"
	COUNT=$[ $COUNT + 1 ]
    for i in . :
    do
        echo "$COUNT) $NMAC" | sed "s/-/$i/g"
		COUNT=$[ $COUNT + 1 ]
    done
    NMAC=`echo $NMAC | tr '[a-z]' '[A-Z]'`
#done

NMAC=`echo $NMAC |sed 's/\(..\)\(..\).\(..\)\(..\).\(..\)\(..\)/\1\2\3-\4\5\6/'`

#for j in 1 2
#do
    echo "$COUNT) $NMAC"
	COUNT=$[ $COUNT + 1 ]
    for i in . :
    do
        echo "$COUNT) $NMAC" | sed "s/-/$i/g"
		COUNT=$[ $COUNT + 1 ]
    done
    NMAC=`echo $NMAC | tr '[A-Z]' '[a-z]'`
ipv6calc=`which ipv6calc`
if [ $? -ne 0 ]
then
	echo -e "\n  install ipv6calc if you want the EUI64 SLAAC IPv6 IP for this MAC address displayed"
	exit 0
else
	echo -n "EUI64 SLAAC IPv6 IP: fe80"
	$ipv6calc --in mac --action geneui64 --out ipv6addr $NMAC
fi
