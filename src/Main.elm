module Main exposing (..)

import Messages exposing (..)
import Model exposing (..)
import Html.Styled exposing (..)
import Navigation exposing (..)
import AnimationFrame exposing (..)
import Update exposing (update)
import View exposing (view)
import Mouse exposing (Position)
import Guards exposing (..)


subs : Mdl -> Sub Msg
subs { clock, interp, target } =
    Sub.batch
        [ (target /= Nothing || interp /= 1)
            => AnimationFrame.diffs Tick
            |= Sub.none
        , Mouse.moves MouseMove
        ]


main : Program Never Mdl Msg
main =
    Navigation.program OnLocationChange
        { view = view >> toUnstyled
        , init = init
        , update = update
        , subscriptions = subs
        }
