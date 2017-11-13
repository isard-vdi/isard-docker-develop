HOSTNAME=`echo "$7" | sed  's/\..*//'`
DOMAIN=`expr "$7" | sed -n 's/[^.]*\.//p'`
echo $HOSTNAME
echo $DOMAIN
