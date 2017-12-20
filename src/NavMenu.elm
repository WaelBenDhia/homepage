module NavMenu exposing (..)

import Html.Styled exposing (..)
import Html.Styled.Events exposing (..)
import Html.Styled.Attributes exposing (..)
import Messages exposing (..)
import Css exposing (..)
import Fonts exposing (..)
import Routing exposing (..)
import List exposing (..)
import Theming exposing (..)


menu =
    List.map (\( r, t ) -> a [ css [ color colors.fg ], onClick <| GoTo r ] [ text t ])
        [ ( Home, "Home" )
        , ( Education, "Education" )
        , ( Work, "Work" )
        , ( Skills, "Skills" )
        ]
