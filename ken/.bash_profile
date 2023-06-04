#
# ~/.bash_profile
#

#export MANGOHUD=0
#export MANGOHUD_DLSYM=0
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

if [[ $XDG_CURRENT_DESKTOP != 'KDE' ]]; then
    #export QT_STYLE_OVERRIDE=adwaita
    export XDG_CONFIG_GOME=~/.config
    export XDG_DATA_HOME=~/.local/share
    export QT_QPA_PLATFORMTHEME=qt5ct
    export GIT_ASKPASS='/usr/bin/ksshaskpass'
    export SSH_ASKPASS='/usr/bin/ksshaskpass'
fi

[[ -f ~/.bashrc ]] && . ~/.bashrc

