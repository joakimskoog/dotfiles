$GithubUrl = "https://github.com/joakimskoog/dotfiles-windows/archive/main.zip";
$DownloadFolder = Join-Path $env:TEMP "dotfiles"
$DownloadedFile = Join-Path $DownloadFolder "dotfiles.zip"
$DotfilesFolder = Join-Path $DownloadFolder "dotfiles-main";

if (Test-Path $DownloadFolder) {
  Remove-Item -Path $DownloadFolder -Recurse -Force;
}
New-Item $DownloadFolder -ItemType directory;

Invoke-WebRequest -Uri $GithubUrl -OutFile $DownloadedFile;


#Add-Type -AssemblyName System.IO.Compression.FileSystem;
#[System.IO.Compression.ZipFile]::ExtractToDirectory($DownloadedFile, $DownloadFolder);

Write-Host $DotfilesFolder;
#$SetupPath = (Join-Path -Path $DownloadFolder -ChildPath "dotfiles-main" | Join-Path -ChildPath "Setup.ps1");

Push-Location $DotfilesFolder;
Invoke-Expression (Join-Path $DotfilesFolder "Setup.ps1")
Pop-Location
