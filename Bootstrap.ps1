Set-Location -Path $HOME
Write-Host "Bootstrapping..." -ForegroundColor "Green"

if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "Setting up Chocolatey..." -ForegroundColor "Green"
    
    Set-ExecutionPolicy Bypass -Scope Process -Force;
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;
    iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

    Write-Host "Chocolatey setup complete" -ForegroundColor "Green"
} else {
    Write-Host "Chocolatey already installed"  -ForegroundColor "Green"
}

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "Setting up Git..." -ForegroundColor "Green"

    choco install -y "git" --params "/GitOnlyOnPath /NoAutoCrlf /NoShellIntegration /NoGuiHereIntegration"

    Write-Host "Git setup complete" -ForegroundColor "Green"
} else {
    Write-Host "Git already installed"  -ForegroundColor "Green"
}

$repo = "$HOME\.dotfiles"
if (-not (Test-Path $repo)) {
    Write-Host "Cloning .dotfiles repository..." -ForegroundColor "Green"
    git clone https://github.com/joakimskoog/.dotfiles.git $repo
    Write-Host "Cloned into $repo" -ForegroundColor "Green"
} else {
    Write-Host "$repo already exists"
}










