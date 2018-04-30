module Main exposing (..)

import AnimationFrame exposing (..)
import Html.Styled exposing (..)
import Messages exposing (..)
import Model exposing (..)
import Mouse exposing (Position)
import Navigation exposing (..)
import Update exposing (update)
import View exposing (view)


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
