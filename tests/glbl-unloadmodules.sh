#!/bin/bash
# we only test if the parameter is accepted - we cannot
# reliably deduce from the outside if it really worked.
# addd 2016-03-03 by RGerhards, released under ASL 2.0
echo \[glbl-unloadmodules\]: 
. $srcdir/diag.sh init
. $srcdir/diag.sh generate-conf
. $srcdir/diag.sh add-conf '
global(debug.unloadModules="off")

action(type="omfile" file="rsyslog.out.log")
'
. $srcdir/diag.sh startup
sleep 1
. $srcdir/diag.sh shutdown-when-empty
. $srcdir/diag.sh wait-shutdown
# to check for support, we check if an error message has
# been recorded, which would bear the name of our option.
# if it is not recorded, we assume all is well. Not perfect,
# but works good enough.
grep -i "unloadModules" < rsyslog.out.log
if [ ! $? -eq 1 ]; then
  echo "parameter name in output, assuming error message:"
  cat rsyslog.out.log
  exit 1
fi;
. $srcdir/diag.sh exit
