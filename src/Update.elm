module Update exposing (update)

import Time exposing (..)
import Animation exposing (..)
import Messages exposing (..)
import Model exposing (..)
import Navigation exposing (..)
import Routing exposing (..)
import Model exposing (Mdl)
import Maybe exposing (withDefault)


simpleAnim : Float -> Float -> Time -> Animation
simpleAnim start end =
    animation >> from start >> to end >> duration (0.4 * second)


handleLocation : Location -> Mdl -> ( Mdl, Cmd msg )
handleLocation location ({ clock } as mdl) =
    ( { mdl
        | target = Just <| parseLocation location
        , transition = simpleAnim 1 0 clock
      }
    , Cmd.none
    )


handleTick : Float -> Mdl -> ( Mdl, Cmd msg )
handleTick dt ({ clock, transition, target, route } as mdl) =
    let
        closedThen val def =
            if getTo transition == 0 && isDone clock transition then
                val
            else
                def
    in
        ( { mdl
            | clock = clock + dt
            , route = closedThen (withDefault route target) route
            , target = closedThen Nothing target
            , transition = closedThen (simpleAnim 0 1 clock) transition
          }
        , Cmd.none
        )


handleRouteChange : Route -> Mdl -> ( Mdl, Cmd msg )
handleRouteChange r ({ route, target } as mdl) =
    ( mdl
    , if r /= route && Just r /= target then
        newUrl <| routeToString r
      else
        Cmd.none
    )


update : Msg -> Mdl -> ( Mdl, Cmd Msg )
update msg mdl =
    case msg of
        OnLocationChange location ->
            handleLocation location mdl

        Tick dt ->
            handleTick dt mdl

        GoTo r ->
            handleRouteChange r mdl

        MouseMove pos ->
            ( { mdl | mousePosition = pos }, Cmd.none )

        MouseOver offset ->
            ( { mdl | mouseOver = offset }, Cmd.none )
