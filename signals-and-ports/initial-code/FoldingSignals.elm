import Graphics.Element exposing (..)
import Keyboard
import Mouse


state : Signal Int
state =
  Signal.foldp (\key count -> count + 1) 0 Keyboard.presses

clicks : Signal Int
clicks =
  Signal.foldp (\click count -> count + 1) 0 Mouse.clicks


main : Signal Element
main =
  Signal.map show clicks
