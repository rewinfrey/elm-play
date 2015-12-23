import Graphics.Element exposing(..)
import Time exposing(..)

everySecond : Signal Time
everySecond =
  Time.every Time.second


runningTime : Signal Int
runningTime =
  Signal.foldp (\_ count -> count + 1) 0 everySecond

main : Signal Element
main =
  Signal.map show runningTime
