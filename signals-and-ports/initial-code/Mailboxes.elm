import Html exposing (..)
import Html.Events exposing (..)


view : Signal.Address String -> String -> Html
view address greeting =
  div []
    [ button
--        [ on "click" targetValue (\_ -> Signal.message inbox.address "Hello")  ]
--        [ onClick inbox.address "Hello" ]
        [ onClick address "Hello" ]
        [ text "Click for English" ],
      button
--        [ on "click" targetValue (\_ -> Signal.message inbox.address "Salut")  ]
--        [ onClick inbox.address "Salut" ]
        [ onClick address "Salut" ]
        [ text "Click for French" ],
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
