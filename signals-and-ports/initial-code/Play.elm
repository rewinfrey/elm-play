import Graphics.Element exposing(..)
import Keyboard
import Char

chars : Signal Char
chars =
  Signal.map Char.fromCode Keyboard.presses

charsSoFar : Signal (List Char)
charsSoFar =
  Signal.foldp (::) [] chars


main : Signal Element
main =
  Signal.map show charsSoFar
