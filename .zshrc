# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt HIST_IGNORE_SPACE
setopt autocd
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/beromer/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

powerline-daemon -q
. /usr/share/powerline/bindings/zsh/powerline.zsh

source /etc/profile.d/lmod.sh
source /home/beromer/src/spack/share/spack/setup-env.sh

bindkey "^?" backward-delete-char

alias ls='ls -Alhp --group-directories-first --color=auto'
alias rm='rm -iv'
alias cp='cp -v'
alias grep='grep --color=auto'
alias less='less -R -S'
#alias less='less -R --mouse -S'
alias fiesta='fiesta --color=auto'

#export DISPLAY=localhost:0

export PATH=$PATH:/home/beromer/local/bin
export CMAKE_GENERATOR=Ninja
