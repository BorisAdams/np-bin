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

mon putDbUsagesCtd --simStatus=Activated   --putDb --NskipCtdInsert  --errorOutput=$errorOutputFile 1>$scriptOutputFile
mon putDbUsagesCtd --simStatus=Deactivated --putDb --skipCtdInsert   --errorOutput=$errorOutputFile 1>>$scriptOutputFile
mon putDbUsagesCtd --simStatus=Retired     --putDb --skipCtdInsert   --errorOutput=$errorOutputFile 1>>$scriptOutputFile

popd

pushd E:\Drives\Dev\NoPowerTxt\
cd .\M2mMonitor\

$pathStr = "./Reports/DailyReports/"
$errorOutputPrefix = $pathStr + "device_writer_errors" 
$dateStr=(Get-Date).ToString("yyyyMMdd")
$dateSuffix = "." + $dateStr + ".wip.txt"
$errorOutputFile = $errorOutputPrefix + $dateSuffix 
$scriptOutputFile = $pathStr + "daily-ctd-output" + $dateSuffix

$null | sc $errorOutputFile

rm $scriptOutputFile

Set-Alias -Name mon_wip -Value .\bin\Debug\net5.0\M2MMonitor.exe

mon_wip putDbUsagesCtd --simStatus=Activated   --NputDb --showSql --skipCtdInsert   --errorOutput=$errorOutputFile 1>$scriptOutputFile
mon_wip putDbUsagesCtd --simStatus=Deactivated --NputDb --showSql --skipCtdInsert   --errorOutput=$errorOutputFile 1>>$scriptOutputFile
mon_wip putDbUsagesCtd --simStatus=Retired     --NputDb --showSql --skipCtdInsert   --errorOutput=$errorOutputFile 1>>$scriptOutputFile

#next - baseline in git!!!

popd
