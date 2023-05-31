#
# ~/.bash_profile
#

export MANGOHUD=0
export MANGOHUD_DLSYM=0
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

if [[ $XDG_CURRENT_DESKTOP != 'KDE' ]]; then
    #export QT_STYLE_OVERRIDE=adwaita
    export QT_QPA_PLATFORMTHEME=qt5ct
fi

#export QT_STYLE_OVERRIDE=adwaita
#export QT_QPA_PLATFORMTHEME=qt5ct
[[ -f ~/.bashrc ]] && . ~/.bashrc

