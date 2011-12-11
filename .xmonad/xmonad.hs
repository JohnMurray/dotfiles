import XMonad
import XMonad.Config.Gnome
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Spacing
import XMonad.Util.Run
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO



main = do
  xmproc <- spawnPipe "/usr/bin/xmobar /home/john/.xmobarrc" 
  xmonad $ defaultConfig
    {manageHook = manageDocks <+> manageHook defaultConfig
    , layoutHook = avoidStruts $ layoutHook defaultConfig
    , logHook = dynamicLogWithPP xmobarPP
         { ppOutput = hPutStrLn xmproc
         , ppTitle = xmobarColor "blue" "" . shorten 50
         , ppLayout = const "" -- to disable the layout info on xmobar
         }
    }
