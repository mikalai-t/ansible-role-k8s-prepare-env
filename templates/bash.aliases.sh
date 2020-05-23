#jinja2: lstrip_blocks: True, trim_blocks: True

DEFAULT_STYLE="\[\033[00m\]"
FONT_BLACK_NORMAL="\[\033[0;30m\]"
FONT_RED_NORMAL="\[\033[0;31m\]"
FONT_RED_BOLD="\[\033[01;31m\]"
FONT_GREEN_NORMAL="\[\033[0;32m\]"
FONT_GREEN_BOLD="\[\033[01;32m\]"
FONT_YELLOW_NORMAL="\[\033[0;33m\]"
FONT_YELLOW_BOLD="\[\033[01;33m\]"
FONT_BLUE_NORMAL="\[\033[0;34m\]"
FONT_BLUE_BOLD="\[\033[01;34m\]"
FONT_CYAN_NORMAL="\[\033[0;36m\]"
FONT_CYAN_BOLD="\[\033[01;36m\]"
FONT_WHITE_NORMAL="\[\033[0;37m\]"
FONT_WHITE_BOLD="\[\033[01;37m\]"


# If not running interactively, don't do anything
case $- in
    *i*)
        [ -z "$PS1" ] && return
        ;;
    *)
        return
        ;;
esac


if [ -n "$BASH" ] && [ "$BASH" != "/bin/sh" ] && [ -n "$BASH_VERSION" ]; then
    # Don't put duplicate lines or lines starting with space in the history.
    HISTCONTROL=ignoreboth

    # Append to the history file, don't overwrite it
    shopt -s histappend

    # For setting history length see HISTSIZE and HISTFILESIZE in bash(1)
    HISTSIZE=1000
    HISTFILESIZE=2000

    # check the window size after each command and, if necessary,
    # update the values of LINES and COLUMNS.
    shopt -s checkwinsize
fi


# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    *term|*color|rxvt|screen|linux)
        color_prompt=yes
        ;;
    *)
        if [ "x" = "x${color_prompt}" ] && [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
            # We have color support; assume it's compliant with Ecma-48
            # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
            # a case would tend to support setf rather than setaf.)
            color_prompt=yes
        else
            color_prompt=
        fi
        ;;
esac

if [ "$color_prompt" = yes ]; then
    if [ "$(id -u)" == "0" ]; then
        PS1="${FONT_RED_BOLD}\u${DEFAULT_STYLE}@${FONT_YELLOW_BOLD}\h${DEFAULT_STYLE}:${FONT_BLUE_BOLD}\w${DEFAULT_STYLE}\\$ "
    else
        PS1="${FONT_GREEN_BOLD}\u${DEFAULT_STYLE}@${FONT_CYAN_NORMAL}\h${DEFAULT_STYLE}:${FONT_BLUE_BOLD}\w${DEFAULT_STYLE}\\$ "
    fi
else
    PS1="\u@\h:\w\$ "
fi
unset color_prompt


# enable color support of ls and handy aliases
alias ll='ls -laF --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'

if [ "$(id -u)" == "0" ]; then
    alias rm='rm -i'
    alias cp='cp -i'
    alias mv='mv -i'
fi
