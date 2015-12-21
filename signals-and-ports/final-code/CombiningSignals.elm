import Graphics.Element exposing (..)
import Mouse
import Window


view: Int -> Int -> Element
view w x =
  let
    side =
      if x < w // 2 then "Left" else "Right"
  in
    show side


main : Signal Element
main =
  Signal.map2 view Window.width Mouse.x
