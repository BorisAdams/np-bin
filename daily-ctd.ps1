pushd E:\Drives\Dev\NoPowerTxt\
cd .\M2mMonitor\

# $pathStr = "./Reports/DailyReports/"
# $errorOutputPrefix = $pathStr + "device_writer_errors" 
# $dateStr=(Get-Date).ToString("yyyyMMdd")
# $dateSuffix = "." + $dateStr + ".txt"
# $errorOutputFile = $errorOutputPrefix + $dateSuffix 
# $scriptOutputFile = $pathStr + "daily-ctd-output" + $dateSuffix
# 
# $null | sc $errorOutputFile
# 
# rm $scriptOutputFile

# Don't know if the skipCtdInsert is needed for the Deactivated and Retired devices. 
# Don't want hundreds of 0's for these, but not confirmed there's a problem

# Set-Alias -Name mon -Value .\baselines\latest\net5.0\M2mMonitor.exe
# 
# mon putDbUsagesCtd --simStatus=Activated   --putDb --NskipCtdInsert  --errorOutput=$errorOutputFile 1>$scriptOutputFile
# mon putDbUsagesCtd --simStatus=Deactivated --putDb --skipCtdInsert   --errorOutput=$errorOutputFile 1>>$scriptOutputFile
# mon putDbUsagesCtd --simStatus=Retired     --putDb --skipCtdInsert   --errorOutput=$errorOutputFile 1>>$scriptOutputFile
# 
# popd
# 
# pushd E:\Drives\Dev\NoPowerTxt\
# cd .\M2mMonitor\

$pathStr = "./Reports/DailyReports/"
$errorOutputPrefix = $pathStr + "device_writer_errors" 
$dateStr=(Get-Date).ToString("yyyyMMdd")
$dateSuffix = "." + $dateStr + ".wip.txt"
$errorOutputFile = $errorOutputPrefix + $dateSuffix 
$scriptOutputFile = $pathStr + "daily-ctd-output" + $dateSuffix

$null | sc $errorOutputFile

rm $scriptOutputFile

# 14/2/22. Make output file readable in WSL. 
# Default PS output is UTF-16, which is readable in notepad++, but WSL treats it as a "binary" file. (dos2unix works)
# See https://stackoverflow.com/questions/40098771/changing-powershells-default-output-encoding-to-utf-8
# Don't know if this is a permanent change, or just for this script.
# echo $PSDefaultParameterValues to see. Looks permanent.
$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8' 

Set-Alias -Name mon_wip -Value .\bin\Debug\net5.0\M2MMonitor.exe

mon_wip putDbUsagesCtd --simStatus=Activated   --putDb --NshowSql --NskipCtdInsert  --errorOutput=$errorOutputFile 1>$scriptOutputFile
mon_wip putDbUsagesCtd --simStatus=Deactivated --putDb --NshowSql --skipCtdInsert   --errorOutput=$errorOutputFile 1>>$scriptOutputFile
mon_wip putDbUsagesCtd --simStatus=Retired     --putDb --NshowSql --skipCtdInsert   --errorOutput=$errorOutputFile 1>>$scriptOutputFile

#next - baseline in git!!!

popd
