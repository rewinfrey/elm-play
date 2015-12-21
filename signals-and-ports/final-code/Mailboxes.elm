import Html exposing (..)
import Html.Events exposing (..)


view : Signal.Address String -> String -> Html
view address greeting =
  div []
    [ button [ onClick address "Hello!" ] [ text "Click for English" ],
      button [ onClick address "Salut!" ] [ text "Click for French" ],
      p [ ] [ text greeting ]
    ]


inbox : Signal.Mailbox String
inbox =
  Signal.mailbox "Waiting..."


messages : Signal String
messages =
  inbox.signal


main : Signal Html
main =
  Signal.map (view inbox.address) messages

