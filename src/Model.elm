module Model exposing (..)

import Routing exposing (..)
import Navigation exposing (..)
import Animation exposing (Animation, animation)
import Time exposing (Time)


type alias Mdl =
    { route : Route
    , interp : Float
    , currentAnimation : Animation
    , clock : Time
    , target : Maybe Route
    , mousePosition : { x : Int, y : Int }
    }


init : Location -> ( Mdl, Cmd msg )
init location =
    let
        page =
            parseLocation location
    in
        ( Mdl page 0.2 (animation 0) 1 Nothing { x = -100, y = -100 }, Cmd.none )
