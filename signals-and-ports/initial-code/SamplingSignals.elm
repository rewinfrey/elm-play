import Graphics.Element exposing (..)
import Mouse
import Time

clickPosition : Signal (Int, Int)
clickPosition =
  Signal.sampleOn delta Mouse.position

delta : Signal Time.Time
delta =
  Signal.map Time.inSeconds (Time.fps 15)

main : Signal Element
main =
  Signal.map show clickPosition
