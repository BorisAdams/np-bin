cd E:\Drives\Dev\NoPowerTxt\
cd .\M2mMonitor\

$pathStr = "./Reports/DailyReports/"
$errorOutputPrefix = $pathStr + "device_writer_errors-dailyctd-" 
$date_str=(Get-Date).ToString("yyyyMMdd")
$errorOutputFile = $errorOutputPrefix + $date_str + ".txt" 
$scriptOutputFile = $pathStr + "daily-ctd-output.txt"

$null | sc $errorOutputFile
rm $scriptOutputFile

.\baselines\latest\net5.0\M2mMonitor.exe putDbUsagesCtd --putDb --errorOutput=$errorOutputFile 1>$scriptOutputFile

