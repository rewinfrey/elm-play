module Thumbs where

import Html exposing (..)
import Html.Events exposing (..)


-- MODEL

type alias Model =
  { ups : Int,
    downs : Int,
    comments : List String
  }


initialModel : Model
initialModel =
  { ups = 0,
    downs = 0,
    comments = []
  }


-- UPDATE

type Action = NoOp | Up | Down | AddComment String

update : Action -> Model -> Model
update action model =
  case action of
    NoOp ->
      model
    Up ->
      { model | ups = model.ups + 1 }
    Down ->
      { model | downs = model.downs + 1 }
    AddComment comment ->
      { model | comments = comment :: model.comments }


-- VIEW

view : Signal.Address Action -> Model -> Html
view address model =
  div []
    [ button [ onClick address Down ]
        [ text ((toString model.downs) ++ " Thumbs Down") ],
      button [ onClick address Up ]
        [ text ((toString model.ups) ++ " Thumbs Up") ],
      commentList model.comments
    ]


commentList : List String -> Html
commentList comments =
  let
    commentItem comment =
      li [ ] [ text comment ]
    commentItems =
      List.map commentItem comments
  in
    ul [ ] commentItems


-- PORTS

port comments : Signal String


port modelChanges : Signal Model
port modelChanges =
  model


-- SIGNALS

inbox : Signal.Mailbox Action
inbox =
  Signal.mailbox NoOp


actions : Signal Action
actions =
  Signal.merge inbox.signal (Signal.map AddComment comments)


model : Signal Model
model =
  Signal.foldp update initialModel actions


main : Signal Html
main =
  Signal.map (view inbox.address) model

