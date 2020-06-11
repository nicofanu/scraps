# vim:ft=sh

alias cd='cd+'                                             # cd, mkdir and ls in one command
alias ..='cd ..'                                           # cd to parent dir
alias -- -='cd ~-'                                         # cd to previous dir

alias ls='ls -h --color=always --time-style=long-iso --group-directories-first'
alias ll='ls -l'
alias la='ls -lA'

alias cp='cp -v -i -r'
alias mv='mv -v -i'
alias rm='rm -v -I -r'
alias shred='shred -u'                                     # securely delete files
alias trash='mkdir -p ~/.trash/ && mv --backup=numbered -f -t ~/.trash/'

alias du='_() { du -hs --apparent-size --total $@ | sort -rh ; } && _'
alias df="df -h | grep --color=no -E '(File|/dev/sd)'"     # hide the devices you don't care about

alias grep='grep -i --color=auto'
alias egrep='egrep --color=auto'
alias histgrep='history | grep'                            # grep through history
alias psgrep='ps -ef | grep'                               # grep through processes
alias pstree='ps axjf'                                     # list process tree

alias less='less -cR'

alias tree='tree -C'

alias wget='wget --no-verbose --show-progress'

alias rsync='rsync -avh --progress'

alias stow='stow -R -v --ignore "\.swp"'
