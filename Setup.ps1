
function Setup-Git {
    #Install git
    Write-Host "Setting up Git..." -ForegroundColor "Green"
    
    choco install -y "git" --params "/GitOnlyOnPath /NoAutoCrlf /NoShellIntegration /NoGuiHereIntegration"
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine")

    $GitUserName = Read-Host -Prompt "Input your git username";
    $GitUserEmail = Read-Host -Prompt "Input your git email";

    Copy-Item -Path ./.gitconfig -Destination $HOME

    git config --global user.name $GitUserName
    git config --global user.email $GitUserEmail


    Write-Host "Git setup complete"  -ForegroundColor "Green"
}

#Set the current location to where the script is so we can reference our other files more easily
$MyInvocation.MyCommand.Path | Split-Path | Push-Location


#Invoke-Expression (Join-Path -Path $DotfilesWorkFolder -ChildPath "Chocolatey" | Join-Path -ChildPath "Chocolatey.ps1");


#Setup-Git;

Pop-Location