
-- Imports.
import XMonad

-- hooks
import XMonad.Hooks.DynamicLog


-- BACKUP
-- import XMonad

-- main = do
--   xmonad $ defaultConfig
--     { terminal    = terminal'
--     , modMask     = modMask'
--     , borderWidth = borderWidth'
--     }

-- terminal'    = "urxvt"
-- modMask' = mod4Mask -- Win key or Super_L
-- borderWidth' = 3
-- BACKUP


-- The main function.
main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig

-- Command to launch the bar.
myBar = "xmobar"

-- Custom PP, configure it as you like. It determines what is being written to the bar.
-- myPP = xmobarPP { ppCurrent = xmobarColor "#429942" "" . wrap "<" ">"
myPP = xmobarPP { ppCurrent = xmobarColor "#B8860B" "" . wrap "<" ">"
                , ppHidden = xmobarColor "#FAFFFF" ""
                , ppHiddenNoWindows = xmobarColor "#FAFFFF" ""
                , ppUrgent = xmobarColor "#FFFFAF" "" . wrap "[" "]"
                , ppLayout = xmobarColor "#aaaaaa" ""
                , ppTitle =  xmobarColor "#aaaaaa" "" . shorten 140
                , ppSep = xmobarColor "#aaaaaa" "" " | "
                }

-- Key binding to toggle the gap for the bar.
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)


-------------------------------------------------------------------------------
-- Configs --
myConfig = defaultConfig { borderWidth = borderWidth'
                         , terminal = terminal'
                         , modMask = modMask'
                         }
-- -- Main configuration, override the defaults to your liking.
-- myConfig = defaultConfig


-------------------------------------------------------------------------------
-- Looks --

-- borders
borderWidth' = 3

-------------------------------------------------------------------------------
-- Terminal --
terminal'    = "urxvt"


-------------------------------------------------------------------------------
-- Keys/Button bindings --
-- modmask
modMask' = mod4Mask -- Win key or Super_L


