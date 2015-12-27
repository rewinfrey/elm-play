module Thumbs where

import Html exposing (..)
import Html.Events exposing (..)


-- MODEL

type alias Model =
  { ups : Int,
    downs : Int,
    comments : List String,
    reset : Bool
  }


initialModel : Model
initialModel =
  let
    emptyModel = { ups = 0, downs = 0, comments = [], reset = False }
  in
    Maybe.withDefault emptyModel getStoredModel


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
      { model | comments = List.append model.comments [comment] }


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


-- PORTS

port comments : Signal String

port modelChanges : Signal Model
port modelChanges =
  model

port setStoredModel : Signal Model
port setStoredModel =
  model

port getStoredModel : Maybe Model

main : Signal Html
main =
  Signal.map (view inbox.address) model

