Import-Module "posh-git";
Import-Module "Terminal-Icons";
Import-Module "PSReadLine";

oh-my-posh --init --shell pwsh --config ~/.oh-my-posh-custom-theme.omp.json | Invoke-Expression;


########## PSReadLine ##########
Set-PSReadLineOption -EditMode Windows
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView

Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

########## Git Aliases ##########
function Git-Status {
    git status -s;
}

Set-Alias -Name "gst" -Value "Git-Status"