#!/bin/sh

scriptname=`basename $0`
scriptdir=${0/$scriptname/}
logfile=$scriptdir/logrotate.log

source $scriptdir/config
source $scriptdir/redirectlog.src.sh

lf=$1

if [ ! -f "$lf" ]; then
	exit 1
fi

if [ `du $lf | awk '{print $1}'` -gt $maxlogsizeinkb ]; then
	echo "logfile \"$lf\" is over size, needs rotating."
	$scriptdir/logrotate.sh $lf
fi
