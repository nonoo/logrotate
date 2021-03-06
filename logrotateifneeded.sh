#!/bin/sh

self=`readlink "$0"`
if [ -z "$self" ]; then
	self=$0
fi
scriptname=`basename "$self"`
scriptdir=${self%$scriptname}

. $scriptdir/config

lf=$1
logcopytruncate=$2

if [ ! -f "$lf" ]; then
	exit 2
fi

if [ `$du $lf | awk '{print $1}'` -gt $maxlogsizeinkb ]; then
	echo "logfile \"$lf\" is over size, needs rotating."
	$scriptdir/logrotate.sh $lf $logcopytruncate

	exit 0
fi

exit 1
