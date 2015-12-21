import Graphics.Element exposing (..)
import Mouse
import Time


delta : Signal Time.Time
delta =
 Signal.map Time.inSeconds (Time.fps 15)


clickPosition : Signal (Int, Int)
clickPosition =
--Signal.sampleOn Mouse.clicks Mouse.position
  Signal.sampleOn delta Mouse.position


main : Signal Element
main =
  Signal.map show clickPosition
