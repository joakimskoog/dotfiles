
Import-Module "posh-git";
#Import-Module "oh-my-posh";
Import-Module "Terminal-Icons";
Import-Module "PSReadLine";


#$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine")
#Set-PoshPrompt -Theme "~/.oh-my-posh-custom-theme.omp.json";
oh-my-posh --init --shell pwsh | Invoke-Expression;