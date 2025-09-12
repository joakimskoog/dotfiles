git config --global alias.cm 'commit -m'
git config --global alias.co 'checkout'
git config --global alias.cob 'checkout -b'
git config --global alias.ls 'log --oneline --decorate --color'
git config --global alias.st 'status -s'

git config --global core.editor nvim
git config --global pull.rebase true

git config --global user.name  "$(Read-Host '[git] user.name')"
git config --global user.email "$(Read-Host '[git] user.email')"