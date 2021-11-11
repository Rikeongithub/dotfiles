# Created by newuser for 5.8
neofetch

###-------------------- CONFIG --------------------###
#
# If not running interactively, don't do anything
 [[ $- != *i* ]] && return

# Enable colors and change prompt:
autoload -U colors && colors

#PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.
setopt interactive_comments

# History in cache directory:
 HISTSIZE=1000
 SAVEHIST=1000
 HISTFILE=~/.cache/zsh/history

autoload -U compinit 
zstyle ':completion:*' menu select

zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# Auto complete with case insenstivity
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# vi mode
 bindkey -v
 export KEYTIMEOUT=1

# Enable searching through history
bindkey '^R' history-incremental-pattern-search-backward

# Edit line in vim buffer ctrl-v
 autoload edit-command-line; zle -N edit-command-line
 bindkey '^v' edit-command-line
# Enter vim buffer from normal mode
 autoload -U edit-command-line && zle -N edit-command-line && bindkey -M vicmd "^v" edit-command-line

# Use vim keys in tab complete menu:
 bindkey -M menuselect 'h' vi-backward-char
 bindkey -M menuselect 'j' vi-down-line-or-history
 bindkey -M menuselect 'k' vi-up-line-or-history
 bindkey -M menuselect 'l' vi-forward-char
 bindkey -M menuselect 'left' vi-backward-char
 bindkey -M menuselect 'down' vi-down-line-or-history
 bindkey -M menuselect 'up' vi-up-line-or-history
 bindkey -M menuselect 'right' vi-forward-char
# Fix backspace bug when switching modes
 bindkey "^?" backward-delete-char

# Change cursor shape for different vi modes.
 function zle-keymap-select () {
     case $KEYMAP in
         vicmd) echo -ne '\e[1 q';;      # block
         viins|main) echo -ne '\e[5 q';; # beam
     esac
}

zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
        echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use lf to switch directories and bind it to ctrl-o
 lfcd () {
     tmp="$(mktemp)"
     lf -last-dir-path="$tmp" "$@"
     if [ -f "$tmp" ]; then
         dir="$(cat "$tmp")"
         rm -f "$tmp" >/dev/null
         [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
     fi
}

bindkey -s '^o' 'lfcd\n'

bindkey -s '^a' 'bc -lq\n'

bindkey -s '^f' 'cd "$(dirname "$(fzf)")"\n'

bindkey '^[[P' delete-char

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

###-------------------- ENV VARIABLES --------------------###

#Set vim as default EDITOR
export VISUAL="vim"
export EDITOR="$VISUAL"

#Set Firefox as default BROWSER
export BROWSER="firefox"

#Set alacritty as default TERM
export TERM="xterm-256color"

###-------------------- THEME --------------------###


###-------------------- SOURCE -------------------###

#source ~/.config/zsh/zsh-plugings/timer.plugin.zsh
#source ~/.config/.zsh/colored-man-page.plugin.zsh
#source ~/.config/zsh/sorin.zsh-theme
#source ~/.config/starship/starship.toml
source ~/.config/zsh/aliases
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


###--------------------- PROMPT -------------------###

eval "$(starship init zsh)"

