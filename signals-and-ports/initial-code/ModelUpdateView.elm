import Graphics.Element exposing (..)
import Keyboard
import Mouse

-- Model

type alias Model = Int

initialModel : Model
initialModel =
  0

-- Update

update : a -> Model -> Model
update even model =
  model + 1

model : Signal Model
model =
  Signal.foldp update initialModel Mouse.clicks


-- View

view : Model -> Element
view model =
  show model

main : Signal Element
main =
  Signal.map view model
