module Update exposing (update)

import Time exposing (..)
import Animation exposing (..)
import Messages exposing (..)
import Model exposing (..)
import Navigation exposing (..)
import Routing exposing (..)
import Guards exposing (..)
import Model exposing (Mdl)


-- import Mouse exposing (Signal)
-- import Signal exposing (..)


doneClosing : Mdl -> Bool
doneClosing { clock, currentAnimation } =
    getTo currentAnimation == 0 && isDone clock currentAnimation


simpleAnim : Float -> Float -> Time -> Animation
simpleAnim start end =
    animation >> from start >> to end >> duration (0.4 * second)


closeAnim : Time -> Animation
closeAnim =
    simpleAnim 1 0


openAnim : Time -> Animation
openAnim =
    simpleAnim 0 1


handleLocation : Location -> Mdl -> ( Mdl, Cmd msg )
handleLocation location model =
    let
        newTarget =
            Just <| parseLocation location
    in
        ( { model
            | target = newTarget
            , currentAnimation = closeAnim model.clock
          }
        , Cmd.none
        )


unpack : Maybe a -> a -> a
unpack val def =
    case val of
        Just v ->
            v

        _ ->
            def


handleTick : Float -> Mdl -> ( Mdl, Cmd msg )
handleTick dt model =
    ( { model
        | clock = model.clock + dt
        , interp = animate model.clock model.currentAnimation
        , route =
            (doneClosing model => unpack model.target model.route)
                |= model.route
        , target =
            (doneClosing model => Nothing)
                |= model.target
        , currentAnimation =
            isRunning model.clock model.currentAnimation
                => model.currentAnimation
                |= (doneClosing model => openAnim model.clock)
                |= model.currentAnimation
      }
    , Cmd.none
    )


handleRouteChange : Route -> Mdl -> ( Mdl, Cmd msg )
handleRouteChange r model =
    ( model
    , (r /= model.route && Just r /= model.target)
        => (newUrl <| routeToString r)
        |= Cmd.none
    )


update : Msg -> Mdl -> ( Mdl, Cmd Msg )
update msg model =
    case msg of
        OnLocationChange location ->
            handleLocation location model

        Tick dt ->
            handleTick dt model

        GoTo r ->
            handleRouteChange r model

        MouseMove pos ->
            ( { model | mousePosition = pos }, Cmd.none )
