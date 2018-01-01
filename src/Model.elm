module Model exposing (..)

import Routing exposing (..)
import Navigation exposing (..)
import Animation exposing (Animation, animation, animate)
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
    let
        page =
            parseLocation location
    in
        ( Mdl
            page
            (animation 0)
            0
            Nothing
            { x = -100, y = -100 }
            Nothing
        , Cmd.none
        )
