Install-Module posh-git -Scope CurrentUser;
choco install oh-my-posh -y
Install-Module -Name "Terminal-Icons";
Install-Module -Name PSReadLine -Force -SkipPublisherCheck;


$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine")
$ThemePath = Join-Path "WindowsTerminal" ".oh-my-posh-custom-theme.omp.json";
Copy-Item $ThemePath -Destination $env:UserProfile;
