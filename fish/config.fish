if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -gx TERM xterm-256color
set -gx EDITOR micro
set -gx VISUAL code

function findandkill
    set port (lsof -n -i4TCP:$argv[1] | grep LISTEN | awk '{print $2}')
    if test -n "$port"
        kill -9 $port
    end
end

alias killport=findandkill

# Custom Garuda aliases

alias untar='tar -zxvf '
alias wget='wget -c '
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias open_wez='hx ~/.wezterm.lua'
set fish_greeting ''

alias open_fish='hx $HOME/.config/fish/config.fish'
alias update_fish='source $HOME/.config/fish/config.fish'
alias open_hx='hx $HOME/.config/helix/config.toml'
alias open_hx_lang='$HOME/.config/helix/languages.toml'
alias ls='exa'
alias prun='poetry run python'

set -gx GOPATH $HOME/go
set -gx GOROOT /opt/homebrew/opt/go/libexec
set -gx JAVA_HOME /Library/Java/JavaVirtualMachines/temurin-20.jdk/Contents/Home

fish_add_path /usr/bin
fish_add_path $HOME/.asdf/shims/
fish_add_path /usr/local/bin
fish_add_path $HOME/.local/share/applications
fish_add_path $HOME/.local/bin/
fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/bin/zig

source /opt/homebrew/opt/asdf/libexec/asdf.fish

zoxide init fish | source
# pnpm
set -gx PNPM_HOME "/Users/takinprofit/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end