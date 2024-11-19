param (
    [String]$pw = $( Read-Host "Password" )
)

$thread = Start-ThreadJob -InputObject ($pw) -ScriptBlock {
    $wshell = New-Object -ComObject wscript.shell;
    $pw = "$($input)~"
    while ($true) {
        while ( -not $wshell.AppActivate("Windows Security")) {
            Start-Sleep 1
        }
        Start-Sleep 1
        $wshell.SendKeys($pw, $true)
        Start-Sleep 1
    }
}

cargo build --release --target i686-pc-windows-msvc
& "C:\Program Files (x86)\Inno Setup 6\ISCC.exe" /DSIGN "/Sstremiosign=`$qC:\Program Files (x86)\Windows Kits\10\bin\10.0.17763.0\x86\signtool.exe`$q sign /t http://timestamp.digicert.com /n `$qSmart Code OOD`$q `$f" "setup\Stremio.iss"

Stop-Job -Job $thread
