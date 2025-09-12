clear
. $HOME/.dotfiles/splash.ps1

echo "`nStarting bootstrap..."
# Install Git for windows because Git is not preinstalled on Windows
winget install --id Git.Git -e --source winget --accept-package-agreements --accept-source-agreements --silent --no-upgrade 1> $null

# Refresh the PATH so we can use Git in the current session
$env:PATH = [System.Environment]::GetEnvironmentVariable("Path", "Machine")

$repo = "https://github.com/joakimskoog/.dotfiles.git"
$repoBranch = "rework"
$repoFolder = "$HOME/.dotfiles"

echo "Cloning from $repo into $repoFolder"
git clone $repo $repoFolder *> $null

if ($repoBranch -ne "main") {
    Push-Location $repoFolder
    git fetch origin $repoBranch *> $null
    git checkout $repoBranch *> $null
    Pop-Location
}

echo "Installing..."
. $HOME/.dotfiles/install.ps1
