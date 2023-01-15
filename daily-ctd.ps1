pushd E:\Drives\Dev\NoPowerTxt\
cd .\M2mMonitor\

$pathStr = "./Reports/DailyReports/"
$errorOutputPrefix = $pathStr + "device_writer_errors" 
$dateStr=(Get-Date).ToString("yyyyMMdd")
$dateSuffix = "." + $dateStr + ".txt"
$errorOutputFile = $errorOutputPrefix + $dateSuffix 
$scriptOutputFile = $pathStr + "daily-ctd-output" + $dateSuffix

$null | sc $errorOutputFile
rm $scriptOutputFile

# Don't know if the skipCtdInsert is needed for the Deactivated and Retired devices. 
# Don't want hundreds of 0's for these, but not confirmed there's a problem

Set-Alias -Name mon -Value .\baselines\latest\net5.0\M2mMonitor.exe

mon putDbUsagesCtd --simStatus=Activated   --NputDb --NskipCtdInsert  --NshowSql --deviceLimit=5 --errorOutput=$errorOutputFile 1>$scriptOutputFile
mon putDbUsagesCtd --simStatus=Deactivated --NputDb --skipCtdInsert   --NshowSql --deviceLimit=5 --errorOutput=$errorOutputFile 1>>$scriptOutputFile
mon putDbUsagesCtd --simStatus=Retired     --NputDb --skipCtdInsert   --NshowSql --deviceLimit=5 --errorOutput=$errorOutputFile 1>>$scriptOutputFile

popd
