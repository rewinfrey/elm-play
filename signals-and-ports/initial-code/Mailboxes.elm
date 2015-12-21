import Html exposing (..)
import Html.Events exposing (..)


view : String -> Html
view greeting =
  div []
    [ button [  ] [ text "Click for English" ],
      p [ ] [ text greeting ]
    ]


main : Html
main =
  view "- - - -"
