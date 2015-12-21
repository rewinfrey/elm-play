import Graphics.Element exposing (..)
import Mouse
import Window
import Keyboard
import Char

area : (Int, Int) -> Int
area (w,h) =
  w * h

windowAreaSignal : Signal Int
windowAreaSignal =
  Signal.map area Window.dimensions

charactersSignal : Signal Char
charactersSignal =
  Signal.map Char.fromCode Keyboard.presses

pressedDigitSignal : Signal Bool
pressedDigitSignal =
  Signal.map Char.isDigit charactersSignal

main : Signal Element
main =
--  Signal.map show windowAreaSignal
--  Signal.map show charactersSignal
  Signal.map show pressedDigitSignal
