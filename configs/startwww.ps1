$taskPhp={
    C:\wnmp\php\php-cgi.exe -b 127.0.0.1:9000 -c C:\wnmp\php\php.ini
}
$taskNginx={
    cd C:\wnmp\nginx
    .\nginx.exe
    cd ..
}
$taskMariadb={
    C:\wnmp\mariadb\bin\mysqld.exe --defaults-file=C:\wnmp\mariadb\data\my.ini
}
$th1=[PowerShell]::Create()
$job1=$th1.AddScript($taskPhp).BeginInvoke()
$th2=[PowerShell]::Create()
$job2=$th2.AddScript($taskNginx).BeginInvoke()
$th3=[PowerShell]::Create()
$job3=$th3.AddScript($taskMariadb).BeginInvoke()