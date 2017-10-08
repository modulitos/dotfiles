#!/bin/bash

# ghc --make xmonad.hs -i -ilib -fforce-recomp -main-is main -v0 -o $1

# dynamic recompilation:
# https://git.archlinux.org/svntogit/community.git/tree/trunk/dynamic-compilation.patch?h=packages/xmonad
# https://github.com/xmonad/xmonad/blob/master/src/XMonad/Core.hs
ghc --make xmonad.hs -i -ilib -fforce-recomp -main-is main -dynamic -v0 -o $1
