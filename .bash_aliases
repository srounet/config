# ~/.bash_aliases: called by bashrc

# Run emacs within a 256-colored terminal
alias emacs='TERM=xterm-256color; emacs -nw'

# Run tmux withing a 256-colored terminal
alias tmux="TERM=screen-256color-bce tmux"

# Make some possibly destructive commands more interactive.
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

# Add some easy shortcuts for formatted directory listings and add a touch of color.
alias ls='ls --color=auto'
alias ll='ls -lF --color=auto'
alias la='ls -alF --color=auto'

# Make grep more user friendly by highlighting matches
# and exclude grepping through .svn folders.
alias grep='grep --color=auto --exclude-dir=\.svn'
