module Messages exposing (..)

import Navigation exposing (Location)
import Time exposing (Time)
import Routing exposing (Route)
import Mouse exposing (Position)


type Msg
    = OnLocationChange Location
    | Tick Time
    | GoTo Route
    | MouseMove Mouse.Position
    | MouseOver (Maybe ( Int, Int ))
