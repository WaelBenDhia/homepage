module Messages exposing (..)

import Navigation exposing (Location)
import Time exposing (Time)
import Routing exposing (Route)


type Msg
    = OnLocationChange Location
    | Tick Time
    | GoTo Route
