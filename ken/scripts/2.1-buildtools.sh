#!/bin/sh
#common build utils
yay -S ninja meson vulkan-headers cmake go extra-cmake-modules esbuild

#node version manager
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
