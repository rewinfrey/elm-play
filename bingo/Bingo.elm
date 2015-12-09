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
  | Mark Int


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


view address model =
  Html.div [ id "container" ]
    [ pageHeader
    , entryList address model.entries
    , sortButton address
    , pageFooter
    ]


-- Wire it together
main =
  StartApp.start
    { model = initialModel
    , view = view
    , update = update
    }
