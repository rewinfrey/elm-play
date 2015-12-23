import Graphics.Element exposing(..)
import Keyboard exposing(..)
import Char exposing(..)
import String exposing(..)

characters : Signal Char
characters =
  Signal.map Char.fromCode Keyboard.presses

parseInt : Char -> Maybe Int
parseInt character =
  case String.toInt (String.fromChar character) of
    Ok value -> Just value
    Err error -> Nothing

integers : Signal Int
integers =
  Signal.filterMap parseInt 0 characters

totalNumbers : Signal Int
totalNumbers =
  Signal.foldp (\num sum -> sum + num) 0 integers

main : Signal Element
main =
  Signal.map show totalNumbers
