### history ###
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_ALL_DUPS

### options ###
setopt autocd
setopt autopushd
setopt pushdignoredups
setopt correct
bindkey -v
zstyle :compinstall filename '/home/beromer/.zshrc'
bindkey ' ' magic-space
autoload -Uz compinit
compinit

### directory aliases ###
alias d='dirs -v | head -5'
alias 1='cd -1'
alias 2='cd ~2'
alias 3='cd ~3'
alias 4='cd ~4'
alias 5='cd ~5'

### history searching in insert mode ###
bindkey "^k" history-beginning-search-backward
bindkey "^j" history-beginning-search-forward

### Activate vi mode ###
bindkey -v

### Remove mode switching delay. ###
KEYTIMEOUT=1

### Change cursor shape for different vi modes. ###
function zle-keymap-select {
    if [[ ${KEYMAP} == vicmd ]] ||
        [[ $1 = 'block' ]]; then
        echo -ne '\e[1 q'
    elif [[ ${KEYMAP} == main ]] ||
        [[ ${KEYMAP} == viins ]] ||
        [[ ${KEYMAP} = '' ]] ||
        [[ $1 = 'beam' ]]; then
        echo -ne '\e[5 q'
    fi
}
zle -N zle-keymap-select
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() {
    echo -ne '\e[5 q' # Use beam shape cursor for each new prompt.
}


### spack and modules ###
source /etc/profile.d/lmod.sh
source /home/beromer/src/spack/share/spack/setup-env.sh

### normal backspace ###
bindkey "^?" backward-delete-char

### personal aliases ###
alias ls='ls -Alhp --group-directories-first --color=auto'
alias rm='rm -iv'
alias vim='nvim'
alias cp='cp -v'
alias grep='grep --color=auto'
alias less='less -R --mouse -S'
alias fiesta='fiesta --color=auto'
alias glog="git log --pretty=format:'%C(yellow)%h%Creset - %Cgreen(%cd) %C(bold blue)<%an>%Creset%Creset %s %C(red)%d' --abbrev-commit"

### path ###
export PATH=$PATH:/home/beromer/local/bin

### personal env variables ###
export CMAKE_GENERATOR=Ninja

### prompt ###
autoload -Uz vcs_info
setopt prompt_subst
precmd() { vcs_info }
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git:*' formats ':%b'
PROMPT='%B%F{11}[%F{9}%n%F{11}]%#%f%b '
RPROMPT='%B%F{11}[%F{10}%~%F{4}${vcs_info_msg_0_}%F{11}][%F{9}%D{%L:%m%p}%F{11}]%f%b'
