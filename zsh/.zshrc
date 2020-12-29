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
bindkey "^p" history-beginning-search-backward
bindkey "^n" history-beginning-search-forward

### Activate vi mode ###
bindkey -v

### Remove mode switching delay. ###
KEYTIMEOUT=1

### Change cursor shape for different vi modes. ###
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
    [[ $1 = 'block' ]]; then
    echo -ne '\e[2 q'
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

### fzf bindings ###
source /home/beromer/opt/fzf/completion.zsh
source /home/beromer/opt/fzf/key-bindings.zsh

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
alias python="python3"
alias py="python3"
alias pip="pip3"
alias nless="nvim -u ~/.config/nvim/less.vim"
alias define='dict'

### path ###
export PATH=$PATH:/home/beromer/local/bin
export PATH=/home/beromer/opt/neovim/nvim-linux64/bin:$PATH

### personal env variables ###
export CMAKE_GENERATOR=Ninja

### prompt ###
autoload -Uz vcs_info
setopt prompt_subst
precmd() { vcs_info }
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git:*' formats '%F{11}[%F{4}%b%F{11}]%f'
PROMPT=''
RPROMPT=''
#PROMPT+='%B%F{11}[%F{9}%n%F{11}]%f%b'           # username
if [ -n "${SSH_CLIENT}" ]; then
  PROMPT+='%B%F{11}[%F{1}%m%F{11}]%f%b'         # cwd
fi
PROMPT+='%B%F{11}[%F{10}%2~%F{11}]%f%b'         # cwd
PROMPT+='%B%F{11}%# %f%b'                       # prompt
RPROMPT+='%B${vcs_info_msg_0_}%b'               # branch
#RPROMPT+='%B%F{11}[%F{9}%D{%L:%M%p}%F{11}]%f%b' # time

# shortcut to open pdf with zathura and detach from shell
function z { command nohup zathura $1 > /dev/null 2>&1 & }
compdef '_files -g "*.pdf"' z
function zc { command nohup zathura -c ~ $1 > /dev/null 2>&1 & }
compdef '_files -g "*.pdf"' zc

compdef '_files -g "*.py"' py

function ndir
{
  command mkdir -p $1 && cd $1
}

export TMX_CONF=/home/beromer/.config/tmux/tmux.conf
function tmx {
  if [ ! -f ./.tmx  ]; then
    bash -c '/home/beromer/.config/tmux/default.tmx'
  else
    bash -c './.tmx'
  fi
}

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -f -g ""'
source /home/beromer/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^ ' autosuggest-accept

alias cowfortune='cowthink $(fortune -s)'
