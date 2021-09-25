# dotfile

Docker container to manage your home directories dotfiles...in a dockerized manner!

Based on <https://antelo.medium.com/how-to-manage-your-dotfiles-with-git-f7aeed8adf8b>

TODO: Move to <https://github.com/anishathalye/dotbot>

## Initial startup 

(not dockerized at the moment - and assuming gpg keys already in place)  - and bit assumptions on how .bashrc looks...

```sh
git init --bare $HOME/.dotfiles
echo "alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.bash_aliases
source $HOME/.bash_aliases
dotfiles config --local status.showUntrackedFiles no
dotfiles secret init
dotfiles secret tell <myemail@domain.tld>
dotfiles add .gpgsecret 
```
