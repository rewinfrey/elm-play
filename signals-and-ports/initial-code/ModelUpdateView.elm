import Graphics.Element exposing (..)
import Keyboard
import Mouse


state : Signal Int
state =
  Signal.foldp (\_ count -> count + 1) 0 Mouse.clicks


main : Signal Element
main =
  Signal.map show state
