# Stop execution on any error
$ErrorActionPreference = "Stop"

$path = "$HOME\.dotfiles"
$pathInstall = "$path\install"

# Packages


# Config
. $pathInstall\config\git.ps1


# Finishing up