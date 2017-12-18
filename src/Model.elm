module Model exposing (..)

import Routing exposing (..)
import Navigation exposing (..)
import Animation exposing (Animation, animation)
import Time exposing (Time)


type alias Model =
    { route : Route
    , interp : Float
    , currentAnimation : Animation
    , clock : Time
    }


init : Location -> ( Model, Cmd msg )
init location =
    ( Model (parseLocation location) 0.2 (animation 0) 1, Cmd.none )
