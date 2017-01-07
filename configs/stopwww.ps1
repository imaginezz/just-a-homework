Get-Process | Where-Object {$_.ProcessName.Contains("nginx") } | Stop-Process -Confirm
Get-Process | Where-Object {$_.ProcessName.Contains("php-cgi") } | Stop-Process -Confirm
Get-Process | Where-Object {$_.ProcessName.Contains("mysqld") } | Stop-Process -Confirm