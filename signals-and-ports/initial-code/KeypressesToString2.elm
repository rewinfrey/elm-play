import Graphics.Element exposing(..)
import String
import Keyboard
import Char

-- Model

type alias Model = String

initialModel : Model
initialModel = ""

-- Signals

characters : Signal Char
characters =
  Signal.map Char.fromCode Keyboard.presses

model : Signal Model
model =
  Signal.foldp update initialModel characters

-- Update
update : Char -> Model -> Model
update char model =
  model ++ (String.fromChar char)

-- View
view : Model -> Element
view model =
  show model

-- Main

main : Signal Element
main =
  Signal.map view model
