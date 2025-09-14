function Symlink {
    param (
        [Parameter(Mandatory=$true)]
        [string]$Target,

        [Parameter(Mandatory=$true)]
        [string]$Link
    )

    New-Item -Path $Link -ItemType SymbolicLink -Value $Target -Force > $null
}

# Stop execution on any error
$ErrorActionPreference = "Stop"

$path = "$HOME/.dotfiles"
$pathInstall = "$path/install"

# Git
Symlink "$path/git/.gitconfig" "$HOME/.gitconfig"
git config --global user.name  "$(Read-Host '[git] user.name')"
git config --global user.email "$(Read-Host '[git] user.email')"