Install-Module posh-git -Scope CurrentUser;
Install-Module -Name "Terminal-Icons";
Install-Module -Name PSReadLine -Force -SkipPublisherCheck;
choco install oh-my-posh -y
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine")

$ThemePath = Join-Path "WindowsTerminal" ".oh-my-posh-custom-theme.omp.json";
Copy-Item $ThemePath -Destination $env:UserProfile;

$ProfilePath = Join-Path "WindowsTerminal" "Microsoft.PowerShell_profile.ps1";
Copy-Item $ProfilePath -Destination $Profile