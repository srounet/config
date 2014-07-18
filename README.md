# Personal config files


### Install

Clone repository and update submodules

```sh
git clone https://github.com/srounet/config.git ~/config
cd ~/config
git submodule update --init --recursive
```

Symlink desired files to your home

```sh
cd ~/
ln -s ~/config/.emacs .
ln -s ~/config/.emacs.d .
ln -s ~/config/.tmux.conf .
ln -s ~/config/.profile .
ln -s ~/config/.bashrc .
ln -s ~/config/.bash_aliases .
```

### Emacs

- Solarized-dark theme

![](http://batsov.com/images/articles/solarized-emacs.png)

- yasnippet (with full snippets collection)
- flymake (syntax check and highlight)
- emacs-nav

![](http://i.imgur.com/Tzid4.png)

- Under emacs hitting "**\<F8>**" will display the folder navigation pane.
- Under emacs hitting "**\<F9>**" will toggle the 80-column bar

### Tmux

Mostly it displays current serveur load on the bottom right of the current window, plus some color configuration, nothing too fancy.

### Bash

Custom aliases that put color everywhere.
