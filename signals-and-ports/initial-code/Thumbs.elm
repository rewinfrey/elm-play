module Thumbs where

import Html exposing (..)
import Html.Events exposing (..)

-- MODEL

type alias Model =
  { ups : Int,
    downs : Int
  }


initialModel : Model
initialModel =
  { ups = 0,
    downs = 0
  }


-- UPDATE

type Action = NoOp | Up | Down


update : Action -> Model -> Model
update action model =
  case action of
    NoOp ->
      model
    Up ->
      { model | ups = model.ups + 1 }
    Down ->
      { model | downs = model.downs + 1 }


-- VIEW

view : Model -> Html
view model =
  div []
    [ button [  ]
        [ text ((toString model.downs) ++ " Thumbs Down") ],
      button [  ]
        [ text ((toString model.ups) ++ " Thumbs Up") ],
      p [ ] [ text (toString model) ]
    ]


main : Html
main =
  view initialModel

