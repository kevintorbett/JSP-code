#!/usr/bin/sh
. /ads/prod/Zap/Env/zapEnv
UserID=$1
Freeze_ind=$2
echo 'Freeze_ind='
echo $Freeze_ind
if [ $Freeze_ind = 'Z' ] || [ $Freeze_ind = 'F' ] 
then
   $BIN/runSql1.sh ZAP_USERID $SQLBIN/zapcdprd.sql $Freeze_ind > $Log/zap_prd2.txt
   VSTATUS=$?
   echo "VSTATUS: $VSTATUS" >> $Log/$LOG_FILE
   if [ $VSTATUS -ne 0 ]
   then
     echo ">>>> ZAP -  Production extract zapcdprd failed" >> $Log/$LOG_FILE
     msg1=' ZAP -  Production extract zapcdprd failed' 
   else
     echo ">>>> ZAP - Production extract zapcdprd completed" >> $Log/$LOG_FILE
     msg1=' ZAP -  Production extract zapcdprd completed'
   fi  
else
    echo ">>>> ZAP -  Production extract zapcdprd failed - wrong input" >> $Log/$LOG_FILE
    msg1=' ZAP -  Production extract zapcdprd failed - wrong input' 
    VSTATUS='1'
fi




 
subject=$msg1
content=$msg1
mailingList=`egrep -v "#" $MAILLIST/zapNotification.lst`

    	
	for eachPerson in $mailingList

	do

       	echo $content  | mailx -s "$subject" $eachPerson

	done
exit $exitcode 





 