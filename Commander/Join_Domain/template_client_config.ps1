<#
To prep or create Client/Template Image
it's recommended that you set the firewall to the commander server only unless required otherwise
- firewall rule is on line 17, substitute "remoteip=any" replacing any with your commander server address.
#>

enable-PSRemoting -Force
winrm quickconfig -q
winrm quickconfig -transport:http
winrm set winrm/config '@{MaxTimeoutms="1800000"}'
winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="800"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'
winrm set winrm/config/client/auth '@{Basic="true"}'
winrm set winrm/config/listener?""Address=*+Transport=HTTP '@{Port="5985"}'
netsh advfirewall firewall set rule group="Windows Remote Administration" new enable=yes
netsh advfirewall firewall set rule name="Windows Remote Management (HTTP-In)" new enable=yes action=allow remoteip=any
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce /v StartWinRM /t REG_SZ /f /d "cmd.exe /c 'sc config winrm start auto & sc start winrm'"
Restart-Service winrm 