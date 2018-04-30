module Model exposing (..)

import Animation exposing (Animation, animate, animation)
import Navigation exposing (..)
import Routing exposing (..)
import Time exposing (Time)


type alias Mdl =
    { route : Route
    , transition : Animation
    , clock : Time
    , target : Maybe Route
    , mousePosition : { x : Int, y : Int }
    , mouseOver : Maybe ( Int, Int )
    }


getInterp : Mdl -> Float
getInterp { clock, transition } =
    animate clock transition


init : Location -> ( Mdl, Cmd msg )
init location =
    ( Mdl
        (parseLocation location)
        (animation 0)
        0
        Nothing
        { x = -100, y = -100 }
        Nothing
    , Cmd.none
    )
