module Bingo where

import Html
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import String
import StartApp.Simple as StartApp
import BingoUtils as Utils

-- Model

type alias Entry =
  { phrase: String
  , points: Int
  , wasSpoken: Bool
  , id: Int }

type alias Model =
  {
    entries: List Entry,
    phraseInput: String,
    pointsInput: String,
    nextID: Int
  }

newEntry : String -> Int -> Int -> Entry
newEntry phrase points id =
  {
    phrase = phrase
  , points = points
  , wasSpoken = False
  , id = id
  }


initialModel : Model
initialModel =
  {
    entries =
      [
        newEntry "Doing Agile" 200 2
      , newEntry "In The Cloud" 300 3
      , newEntry "Future-Proof" 100 1
      , newEntry "Rock-Star Ninja" 400 4
      ],
    phraseInput = "",
    pointsInput = "",
    nextID = 5
  }


-- Update
type Action
  = NoOp
  | Sort
  | Delete Int
  | Mark Int
  | UpdatePhraseInput String
  | UpdatePointsInput String
  | Add


update : Action -> Model -> Model
update action model =
  case action of
    NoOp ->
      model

    Sort ->
      { model | entries = List.sortBy .points model.entries }

    Delete id ->
      let
        remainingEntries =
          List.filter (\e -> e.id /= id) model.entries
      in
      { model | entries = remainingEntries }

    Mark id ->
      let
        updateEntry e =
          if e.id == id
             then { e | wasSpoken = (not e.wasSpoken) }
             else e
      in
        { model | entries = List.map updateEntry model.entries }

    UpdatePhraseInput contents ->
      { model | phraseInput = contents }

    UpdatePointsInput contents ->
      { model | pointsInput = contents }

    Add ->
      let
        entryToAdd =
          newEntry model.phraseInput (Utils.parseInt model.pointsInput) model.nextID
        isInvalid model =
          String.isEmpty model.phraseInput || String.isEmpty model.pointsInput
      in
        if isInvalid model
        then model
        else
          { model |
              phraseInput = "",
              pointsInput = "",
              entries = entryToAdd :: model.entries,
              nextID = model.nextID + 1
          }


-- View

title : String -> Int -> Html.Html
title message times =
  message ++ " "
    |> String.toUpper
    |> String.repeat times
    |> String.trimRight
    |> Html.text

pageHeader : Html.Html
pageHeader =
  Html.h1 [ ] [ title "bingo!" 3 ]


sortButton address =
  Html.button
    [ class "sort", Html.Events.onClick address Sort ]
    [ Html.text "Sort" ]


pageFooter =
  Html.footer [ ]
  [ Html.a [ href "http://localhost:8000" ]
           [ Html.text "reset the page!" ] ]


entryItem : Signal.Address Action -> Entry -> Html.Html
entryItem address entry =
  Html.li
    [ classList [ ("highlight", entry.wasSpoken) ]
    , onClick address (Mark entry.id)
    ]
    [ Html.span [ class "phrase" ] [ Html.text entry.phrase ]
    , Html.span [ class "points" ] [ Html.text (toString entry.points) ]
    , Html.button
        [ class "delete", Html.Events.onClick address (Delete entry.id) ]
        [ ]
    ]

totalPoints : List Entry -> Int
totalPoints entries =
  entries
    |> List.filter .wasSpoken
    |> List.foldl (\e sum -> sum + e.points) 0


totalItem total =
  Html.li
    [ class "total" ]
    [ Html.span [ class "label" ]
                [ Html.text "Total" ],
      Html.span [ class "points" ]
                [ Html.text (toString total) ]
    ]


entryList address entries =
  let
    entryItems = List.map (entryItem address) entries
    items = entryItems ++ [ totalItem (totalPoints entries) ]
  in
    Html.ul [ ] items

entryForm : Signal.Address Action -> Model -> Html.Html
entryForm address model =
  Html.div [ ]
    [ Html.input
        [ type' "text",
          placeholder "Phrase",
          value model.phraseInput,
          name "phrase",
          autofocus True,
          Utils.onInput address UpdatePhraseInput
        ]
        [],
      Html.input
        [ type' "number",
          placeholder "Points",
          value model.pointsInput,
          name "points",
          Utils.onInput address UpdatePointsInput
        ]
        [ ],
      Html.button [ class "add", onClick address Add ] [ Html.text "Add" ],
      Html.h2 [ ] [ Html.text (model.phraseInput ++ " " ++ model.pointsInput) ]
    ]


view : Signal.Address Action -> Model -> Html.Html
view address model =
  Html.div [ id "container" ]
    [ pageHeader
    , entryForm address model
    , entryList address model.entries
    , sortButton address
    , pageFooter
    ]


-- Wire it together
main : Signal Html.Html
main =
  StartApp.start
    { model = initialModel
    , view = view
    , update = update
    }
