### history ###
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_ALL_DUPS

### options ###
setopt rmstarsilent
setopt autocd
setopt autopushd
setopt pushdignoredups
setopt correct
setopt interactivecomments
setopt noclobber
zstyle :compinstall filename '/.zshrc'
bindkey ' ' magic-space
autoload -Uz compinit && compinit
set -o emacs
autoload -U select-word-style && select-word-style bash

### normal backspace ###
bindkey "^?" backward-delete-char

### aliases ###
alias ls='ls -Alhp --group-directories-first --color=auto'
alias rm='rm -iv'
alias cp='cp -v'
alias grep='grep --color=auto'
alias less='less -R --mouse -S'
alias glog="git log --pretty=format:'%C(yellow)%h%Creset - %Cgreen(%cd) %C(bold blue)<%an>%Creset%Creset %s %C(red)%d' --abbrev-commit"
alias python="python3"
alias py="python3"
alias pip="pip3"

### path ###
export PATH=$PATH:/local/bin:/.local/bin

export EDITOR="emacs -nw"
export BROWSER=firefox

### prompt ###
autoload -Uz vcs_info
setopt prompt_subst
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '[%b]'
PROMPT=''
RPROMPT=''
if [ -n "${SSH_CLIENT}" ]; then
  PROMPT+='%B%F{11}[%F{1}%m%F{11}]%f%b'         # cwd
  export TERM=xterm-256color
fi
PROMPT="%B%2~ %(1j.%B%F{1}%j%F{1}.%f%b)%F{1}> %f%b"
RPROMPT="%B${vcs_info_msg_0_}%b"

### plugins ###
if [ -f ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
    bindkey '^ ' autosuggest-accept
fi

if [ -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

### emacs ###
if [[ "$INSIDE_EMACS" = 'vterm' ]] \
    && [[ -n ${EMACS_VTERM_PATH} ]] \
    && [[ -f ${EMACS_VTERM_PATH}/etc/emacs-vterm-zsh.sh ]]; then
    source ${EMACS_VTERM_PATH}/etc/emacs-vterm-zsh.sh
    find_file() {
        vterm_cmd find-file "$(realpath "${@:-.}")"
    }
fi
alias emacs='emacs -nw'

### local config ###
if[ -f ~/.zsh.local ]; then
    source ~/.zsh.local
fi

