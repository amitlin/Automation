# Check if shell is elevated
$IsAdmin = [bool](([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match "S-1-5-32-544")

if (!$IsAdmin) {
    Read-Host "This script must be run from an elevated shell"
    exit
}

# Check if chocolatey is already installed

try {
    get-packageprovider -name "Chocolatey" | out-null
}catch{
    # Attempt to download chocolatey
    Write-Host "Downloading Chocolatey..."

    try {
        Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')) -ErrorAction Stop
    }catch {
        Write-Host $_.Exception.Message
        Read-Host "Encountered an error while downloading Chocolatey, exiting..."
        exit
    }
}


# Once installed, attempt to download and install packages
$packages = @("7zip","vlc", "sublimetext3", "putty.install", "winscp.install", "atom", "sysinternals", "nodejs.install", "virtualbox", "vagrant", "waterfox", "enpass.install", "discord")

Write-Host "Downloading packages..."
Write-Host "Packages: $packages"

$results = @{}
$packages | ForEach { 
    try{
        choco install -y $_
        $results.Add($_, $True)
    }catch {
        $results.Add($_, $False)
    }
}

write-host "Package installations finished!"

# get the packages that failed, if at all
$failures = @()
$results.Keys | foreach-object {if ($results[$_] -eq $False) {
    $failures += $_      
}}


write-host "Packages installation status: $results"

if ($failures.length -gt 0) {
    write-host "Installation of the following packages failed: $failures"
    write-host "You might want to attempt manual installation of these packages."
}

write-host "Done!"
