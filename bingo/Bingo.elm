module Bingo where

import Html
import Html.Attributes exposing (..)
import String

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

update action model =
  case action of
    NoOp ->
      model

    Sort ->
      { model | entries = List.sortBy .points model.entries }

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


entryItem entry =
  Html.li [ ]
    [ Html.span [ class "phrase" ] [ Html.text entry.phrase ]
    , Html.span [ class "points" ] [ Html.text (toString entry.points) ]
    ]


entryList entries =
  Html.ul [ ] (List.map entryItem entries)


view model =
  Html.div [ id "container" ]
    [ pageHeader
    , entryList model.entries
    , pageFooter
    ]

-- Wire it together

main =
  initialModel
    |> update Sort
    |> view
