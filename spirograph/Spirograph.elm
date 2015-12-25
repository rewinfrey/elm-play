module Spirograph where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.Lazy exposing (lazy, lazy2, lazy3)
import Signal exposing (Signal, Address)
import String
import Window

--- Model ---
type alias Spiro =
  { xc : Int
  , yc : Int
  , col: (Int, Int, Int)
  , outerR : Int
  , innerR : Int
  , segmentLength : Int
  }

-- View --


-- Main --
