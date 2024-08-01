type nvim > /dev/null 2>&1 && alias vim='nvim'
type lsd  > /dev/null 2>&1 && alias ls='lsd'

alias t='tmux attach || tmux'
alias e='tmux suspend-client || exit'

alias l='ls'
alias la='ls -a'
alias ll='ls -lh'
alias lla='ls -alh'
alias lh='du --max-depth=1 -h --exclude="./.*"'
alias lah='du --max-depth=1 -h'

alias c='clear'
alias resource='source ~/.bashrc'
alias rime='killall fcitx5 && fcitx5-remote -r'
alias baidu='curl https://www.baidu.com'
alias google='curl https://www.google.com'
alias ffrecord='ffmpeg -video_size 2240x1400 -r 60 -f x11grab -i :0.0 -f pulse -i $(pactl list sinks | grep $(pactl get-default-sink).monitor | cut -d : -f 2) -qscale 0 ~/video/$(date +%Y-%m-%d_%H-%M-%S.mkv)'
