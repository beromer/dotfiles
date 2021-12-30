if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting

    function edit_cmd --description 'Edit cmdline in editor'
        set -l f (mktemp /tmp/fish.cmd.XXXXXXXX)
        # set -l p (commandline -C)
        commandline -b > $f
        vim -c set\ ft=fish $f
        commandline -r (more $f)
        # commandline -C $p
        /bin/rm $f
    end

    function fish_user_key_bindings
        for mode in insert default visual
            bind -M $mode -k nul accept-autosuggestion
            bind -M $mode \cp history-search-backward
            bind -M $mode \cn history-search-forward
            bind -M $mode \ce edit_cmd
        end
    end

    fish_vi_key_bindings
    fish_user_key_bindings

    # alias ls='gls -lh --group-directories-first --color=auto'
    # alias ls 'exa --long --no-user --no-permissions --git --group-directories-first -F'
    alias ls 'exa --long --git --group-directories-first -F'
    alias rm='grm -iv'
    alias vim='nvim'
    alias cp='gcp -v'
    alias grep='grep --color=auto'
    alias fiesta='~/src/fiesta/install/fiesta --color=auto'
    alias glog="git log --pretty=format:'%C(yellow)%h%Creset - %Cgreen(%cd) %C(bold blue)<%an>%Creset%Creset %s %C(red)%d' --abbrev-commit"
    alias python="python3"
    alias py="python3"
    alias pip="pip3"
    alias less="nvim -u ~/.config/nvim/less.vim"
    alias config='git -C ~/dotfiles'
    alias bat='bat --paging=never --style=numbers,changes --theme="Solarized (dark)"'
    alias zathura='zathura -c ~/.config/zathura/'
    alias luamake=/Users/beromer/tmp/lua-language-server/3rd/luamake/luamake

    set -x PATH $PATH:/Users/beromer/scripts:/Users/beromer/.local/bin
    eval (/opt/homebrew/bin/brew shellenv)
    set -x MANPAGER ~/.config/nvim/manpager.sh
    set -x CMAKE_GENERATOR Ninja
    set -x EDITOR nvim
    set -x MANPATH $MANPATH:/Users/beromer/.local/share/man

    eval (gdircolors -c ~/sol.dark)
end
