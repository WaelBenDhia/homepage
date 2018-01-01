module Main exposing (..)

import Messages exposing (..)
import Model exposing (..)
import Html.Styled exposing (..)
import Navigation exposing (..)
import AnimationFrame exposing (..)
import Update exposing (update)
import View exposing (view)
import Mouse exposing (Position)


subs : Mdl -> Sub Msg
subs ({ clock, target } as mdl) =
    Sub.batch
        [ if target /= Nothing || getInterp mdl /= 1 then
            AnimationFrame.diffs Tick
          else
            Sub.none
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
