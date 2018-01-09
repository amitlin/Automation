& {
 $wid=[System.Security.Principal.WindowsIdentity]::GetCurrent()
 $prp=new-object System.Security.Principal.WindowsPrincipal($wid)
 $adm=[System.Security.Principal.WindowsBuiltInRole]::Administrator
 $IsAdmin=$prp.IsInRole($adm)
 if (-not $IsAdmin)
 {
    write-host "You must run this script in an elevated shell!"
    exit
 }
}

$programs = "7zip.install", "waterfox", "putty.install", "winscp.install", "sublimetext3", "nodejs.install", "sysinternals", "atom", "gitkraken", "vagrant", "docker-for-windows"

write-host "Installing chocolatey..."
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
write-host "Chocolatey installed!"

$installString = $programs -join " "

echo y | choco install -y $installString
