import Graphics.Element exposing (..)
import Mouse
import Window
import Keyboard
import Char

characters : Signal Char
characters =
  Signal.map Char.fromCode Keyboard.presses

pressedDigit : Signal Bool
pressedDigit =
  Signal.map Char.isDigit characters

main : Signal Element
main =
  Signal.map show pressedDigit
