import Graphics.Element exposing (..)
import Mouse

-- MODEL

type alias Model = Int


initialModel : Model
initialModel = 0

-- UPDATE

update : a -> Model -> Model
update action model =
  model + 1


model : Signal Model
model =
  Signal.foldp update initialModel Mouse.clicks


-- VIEW

view : Model -> Element
view model =
  show model


main : Signal Element
main =
  Signal.map view model
