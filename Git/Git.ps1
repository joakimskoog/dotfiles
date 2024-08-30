#Install git
Write-Host "Setting up Git..." -ForegroundColor "Green"
    
choco install -y "git" --params "/GitOnlyOnPath /NoAutoCrlf /NoShellIntegration /NoGuiHereIntegration"
#$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine")

#$GitUserName = Read-Host -Prompt "Input your git username";
#$GitUserEmail = Read-Host -Prompt "Input your git email";

Copy-Item -Path (Join-Path "Git" ".gitconfig") -Destination $HOME

#git config --global user.name $GitUserName
#git config --global user.email $GitUserEmail


Write-Host "Git setup complete" -ForegroundColor "Green"
