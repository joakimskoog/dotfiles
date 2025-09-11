Write-Host "Configuring Git..." -ForegroundColor "Green"
    
New-Item -ItemType SymbolicLink `
    -Path (Join-Path $HOME ".gitconfig") `
    -Target (Join-Path "Git" ".gitconfig")

$GitUserName = Read-Host -Prompt "user.name";
git config --global user.name $GitUserName

$GitUserEmail = Read-Host -Prompt "user.email";
git config --global user.email $GitUserEmail

Write-Host "Git configuration done" -ForegroundColor "Green"