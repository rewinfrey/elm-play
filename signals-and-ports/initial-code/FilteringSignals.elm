import Graphics.Element exposing (..)
import String
import Keyboard
import Char


characters : Signal Char
characters =
  Signal.map Char.fromCode Keyboard.presses


numbers : Signal Char
numbers =
  Signal.filter Char.isDigit '1' characters

noDups : Signal Char
noDups =
  Signal.dropRepeats numbers

parseInt : Char -> Maybe Int
parseInt character =
  case String.toInt (String.fromChar character) of
    Ok value -> Just value
    Err error -> Nothing

integers : Signal Int
integers =
  Signal.filterMap parseInt 0 characters

main : Signal Element
main =
  Signal.map show integers
