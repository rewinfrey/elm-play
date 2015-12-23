import Graphics.Element exposing (..)
import String
import Keyboard
import Char

-- Model

type alias Model = String

initialModel : Model
initialModel = ""

-- Update
chars : Signal Char
chars =
  Signal.map Char.fromCode Keyboard.presses

strings : Signal String
strings =
  Signal.map String.fromChar chars

model : Signal Model
model =
  Signal.foldp (\event model -> model ++ event) initialModel strings

-- View
view : Model -> Element
view model =
  show model

main : Signal Element
main =
  Signal.map view model
