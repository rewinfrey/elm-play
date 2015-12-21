module Spaceship where

import Graphics.Element exposing (..)
import Graphics.Collage exposing (..)
import Color exposing (..)

import Keyboard
import Window
import Time


-- MODEL

type alias Model =
  { position: Int,
    powerLevel: Int,
    isFiring: Bool
  }


initialShip : Model
initialShip =
  { position = 0,
    powerLevel = 10,
    isFiring = False
  }


-- VIEW

view : Model -> Element
view ship =
  let
    (w, h) = (400, 400)
    (w', h') = (toFloat w, toFloat h)
  in
    collage w h
      [ drawGame w' h',
        drawShip h' ship,
        toForm (show ship)
      ]


drawGame : Float -> Float -> Form
drawGame w h =
  rect w h
    |> filled gray


drawShip : Float -> Model -> Form
drawShip gameHeight ship =
  let
    shipColor =
      if ship.isFiring then red else blue
  in
    ngon 3 30
      |> filled shipColor
      |> rotate (degrees 90)
      |> move ((toFloat ship.position), (50 - gameHeight / 2))
      |> alpha ((toFloat ship.powerLevel) / 10)


main : Element
main =
  view initialShip
