cd E:\Drives\Dev\NoPowerTxt\
cd .\M2mMonitor\

$pathStr = "./Reports/DailyReports/"
$errorOutputPrefix = $pathStr + "device_writer_errors-dailyctd-" 
$date_str=(Get-Date).ToString("yyyyMMdd")
$errorOutputFile = $errorOutputPrefix + $date_str + ".txt" 
$scriptOutputFile = $pathStr + "daily-ctd-output.txt"

$null | sc $errorOutputFile
rm $scriptOutputFile

# Don't know if the skipCtdInsert is needed for the Deactivated and Retired devices. 
# Don't want hundreds of 0's for these, but not confirmed there's a problem

.\baselines\latest\net5.0\M2mMonitor.exe putDbUsagesCtd --simStatus=Activated   --putDb --NskipCtdInsert --NshowSql --errorOutput=$errorOutputFile 1>$scriptOutputFile
.\baselines\latest\net5.0\M2mMonitor.exe putDbUsagesCtd --simStatus=Deactivated --putDb --skipCtdInsert --NshowSql --errorOutput=$errorOutputFile 1>>$scriptOutputFile
.\baselines\latest\net5.0\M2mMonitor.exe putDbUsagesCtd --simStatus=Retired     --putDb --skipCtdInsert --NshowSql --errorOutput=$errorOutputFile 1>>$scriptOutputFile
