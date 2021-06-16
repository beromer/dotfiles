#           _              
#   _______| |__  _ __ ___ 
#  |_  / __| '_ \| '__/ __|
#   / /\__ \ | | | | | (__ 
#  /___|___/_| |_|_|  \___|
#                          


### history ###
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
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
bindkey -v
zstyle :compinstall filename '/.zshrc'
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
if [[ -f ~/src/spack/share/spack/setup-env.sh ]]; then
  source ~/src/spack/share/spack/setup-env.sh
fi
if [[ -f /etc/profile.d/lmod.sh ]]; then
  source /etc/profile.d/lmod.sh
fi
export LMOD_PAGER=none

### fzf bindings ###
source ~/opt/fzf/completion.zsh
source ~/opt/fzf/key-bindings.zsh

### normal backspace ###
bindkey "^?" backward-delete-char

### personal aliases ###
if ! type "$exa" > /dev/null; then
  alias ls='ls -Alhp --group-directories-first --color=auto'
else
  alias ls='exa --long --no-user --no-permissions --git --group-directories-first -F'
fi
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
#alias less="nvim -u ~/.config/nvim/less.vim"
alias define='dict'
alias icat='kitty +kitten icat'
alias feh='feh --scale-down --auto-zoom'
alias ccmake='TERM=xterm-256color ccmake'
#alias weather='curl wttr.in/Albuquerque\?format=4'
alias forecast='curl wttr.in/Albuquerque'
alias weather='curl wttr.in/Albuquerque\?format="%C\n%t+%w\nSunrise:+%S\nSunset:+%s\n"'
alias config='git -C ~/dotfiles'
alias bat='bat --paging=never --style=numbers,changes --theme gruvbox-dark'

### path ###
export PATH=$PATH:/local/bin:/.local/bin
export PATH=~/opt/neovim/nvim-linux64/bin:$PATH

### qt theme ###
export QT_QPA_PLATFORMTHEME=qt5ct

### use vim as manpager ###
export MANPAGER=/.config/nvim/manpager.sh

### personal env variables ###
export CMAKE_GENERATOR=Ninja

export EDITOR=nvim
export BROWSER=firefox

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
  export TERM=xterm-256color
fi
PROMPT+='%B%F{11}[%F{10}%2~%F{11}]%f%b'         # cwd
PROMPT+='%(1j.%B%F{11}[%F{9}%j%F{11}].%f%b)'    # number of bg processes
#PROMPT+='%B%F{11}[%F{9}%(1j.%j.)%F{11}]%f%b'    # number of bg processes
PROMPT+='%B%F{11}%# %f%b'                       # prompt
RPROMPT+='%B${vcs_info_msg_0_}%b'               # branch
#RPROMPT+='%B%F{11}[%F{9}%D{%L:%M%p}%F{11}]%f%b' # time

# shortcut to open pdf with zathura and detach from shell
function z { command nohup zathura $1 > /dev/null 2>&1 & }
compdef '_files -g "*.pdf"' z
function zd { command nohup zathura -c ~/.config/zathura/dark $1 > /dev/null 2>&1 & }
compdef '_files -g "*.pdf"' zd

compdef '_files -g "*.py"' py

function ndir
{
  command mkdir -p $1 && cd $1
}

export TMX_CONF=/.config/tmux/tmux.conf
function tmx {
  if [ ! -f ./.tmx  ]; then
    bash -c '/.config/tmux/default.tmx'
  else
    bash -c './.tmx'
  fi
}

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -f -g ""'
source /.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^ ' autosuggest-accept

source ~/opt/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

p () {
    local open
    open=zathura   # on OSX, "open" opens a pdf in preview
    ag -U -g ".pdf$" \
    | ~/opt/fast-p/fast-p \
    | fzf --read0 --reverse -e -d $'\t'  \
        --preview-window down:80% --preview '
            v=$(echo {q} | tr " " "|"); 
            echo -e {1}"\n"{2} | grep -E "^|$v" -i --color=always;
        ' \
    | cut -z -f 1 -d $'\t' | tr -d '\n' | xargs -r --null $open > /dev/null 2> /dev/null
}
