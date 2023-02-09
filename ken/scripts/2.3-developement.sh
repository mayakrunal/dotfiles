#!/bin/sh
#common build utils
yay -S python python-pip ninja meson vulkan-headers cmake go extra-cmake-modules esbuild

#node version manager
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

#install visual studio code
yay -S visual-studio-code-bin

#install jdk
yay -S jdk8-openjdk openjdk8-doc openjdk8-src
yay -S jdk11-openjdk openjdk11-doc openjdk11-src
yay -S jdk17-openjdk openjdk17-doc openjdk17-src

## see the staus using command
archlinux-java status
archlinux-java set java-17-openjdk

# install maven
yay -S maven intellij-idea-community-edition

#install code-blocks
yay -S codeblocks

#install pycharm community edition
yay -S pycharm-community-edition

#install .net core
yay -S dotnet-sdk aspnet-runtime aspnet-targeting-pack
