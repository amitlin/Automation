$programs = "7zip.install", "waterfox", "putty.install", "winscp.install", "sublimetext3", "nodejs.install", "sysinternals", "atom", "gitkraken", "vagrant", "docker-for-windows"

write-host "Installing chocolatey..."
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
write-host "Chocolatey installed!"

$installString = $programs -join " "

echo y | choco install -y $installString
