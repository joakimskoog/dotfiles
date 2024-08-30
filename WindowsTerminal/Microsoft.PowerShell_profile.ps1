Import-Module "posh-git";
Import-Module "Terminal-Icons";
Import-Module "PSReadLine";

oh-my-posh --init --shell pwsh --config ~/.oh-my-posh-custom-theme.omp.json | Invoke-Expression;

########## Git Aliases ##########
function Git-Status {
    git status -s;
}

Set-Alias -Name "gst" -Value "Git-Status"