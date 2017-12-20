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
    , target : Route
    }


init : Location -> ( Model, Cmd msg )
init location =
    let
        page =
            parseLocation location
    in
        ( Model page 0.2 (animation 0) 1 page, Cmd.none )
