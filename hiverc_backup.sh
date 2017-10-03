#!/bin/bash
nagios="ip-10-240-4-16.us-west-2.compute.internal"
exted[0]='abo-lp-exted01.hgstbdp.local'
exted[1]='abo-lp-exted02.hgstbdp.local'
for i in 0 1
        do
        ans=$(ssh ${exted[i]} '[ -f /etc/hive/conf/.hiverc ] && echo "File exist" || echo "File does not exist"')
        if [ "$ans" = "File exist" ]
        then
                echo Done
        else
             	 scp /home/monitor/scripts/updatehiverc/.hiverc ${exted[i]}:/etc/hive/conf
                echo ".hiverc was not present on ${exted[i]}. It has succesfully been copied back on ${exted[i]}" | mail -s ".hiverc Alert" -S smtp="10.86.1.25:25" HM230067@teradata.com
        fi
        done

