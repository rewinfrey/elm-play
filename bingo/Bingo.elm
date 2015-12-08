module Bingo where

import Html
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import String
import StartApp.Simple as StartApp

-- Model

newEntry phrase points id =
  {
    phrase = phrase
  , points = points
  , wasSpoken = False
  , id = id
  }


initialModel =
  {
    entries =
      [
        newEntry "Doing Agile" 200 2
      , newEntry "In The Cloud" 300 3
      , newEntry "Future-Proof" 100 1
      , newEntry "Rock-Star Ninja" 400 4
      ]
  }

-- Update

type Action
  = NoOp
  | Sort
  | Delete Int

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

-- View

title : String -> Int -> Html.Html
title message times =
  message ++ " "
    |> String.toUpper
    |> String.repeat times
    |> String.trimRight
    |> Html.text


pageHeader =
  Html.h1 [ ] [ title "bingo!" 3 ]


pageFooter =
  Html.footer [ ]
  [ Html.a [ href "http://localhost:8000" ]
           [ Html.text "reset the page!" ] ]


entryItem address entry =
  Html.li [ ]
    [ Html.span [ class "phrase" ] [ Html.text entry.phrase ]
    , Html.span [ class "points" ] [ Html.text (toString entry.points) ]
    , Html.button
        [ class "delete", Html.Events.onClick address (Delete entry.id) ]
        [ ]
    ]


entryList address entries =
  let
      entryItems = List.map (entryItem address) entries
  in
  Html.ul [ ] entryItems


view address model =
  Html.div [ id "container" ]
    [ pageHeader
    , entryList address model.entries
    , Html.button
        [ class "sort", Html.Events.onClick address Sort ]
        [ Html.text "Sort" ]
    , pageFooter
    ]

-- Wire it together

main =
--  initialModel
--    |> update Sort
--    |> view
  StartApp.start
    { model = initialModel
    , view = view
    , update = update
    }
