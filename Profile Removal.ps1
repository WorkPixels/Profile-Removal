Clear-History
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`" `"$args`"" -Verb RunAs; exit }
cls
$choice = $Null

Do {
 
$choice = Read-Host "This will delete User profiles older than 90 days.
[Yes] to DELETE these files. [No] to EXIT this script.
Please make your selection"

if ($choice -eq 'yes') {

Foreach ($user in $users) {

Get-ChildItem -Path C:\Users* -Exclude *.doc, *.jpg, *.xls, *.pptx, Public* | Where {$_.LastWriteTime -lt $(Get-Date).Date.AddDays(-90)} | Remove-Item -Recurse -Force
Get-CimInstance win32_userprofile -Verbose | Where {$_.LastUseTime -lt $(Get-Date).Date.AddDays(-90)} | Remove-CimInstance -Verbose

}
 
if($choice -eq 'no') {
 ""
 Write-Host "User selected to exit script"
 Sleep -Seconds 5
 Exit
 }
 }
 }While ($choice -eq "")
  
 ''
 Write-Host "Script is Complete"
 Sleep -Seconds 5
 Exit