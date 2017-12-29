module Pointer exposing (pointer)

import Model exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Css exposing (..)
import Theming exposing (..)
import Guards exposing (..)


pointer : Mdl -> Html msg
pointer { mousePosition, interp, route } =
    let
        size =
            32 + 64 * (1 - interp)

        innerSize =
            (1 - interp) * size

        pointerStyle s =
            [ position absolute
            , left <| px <| (toFloat mousePosition.x) - s / 2
            , top <| px <| (toFloat mousePosition.y) - s / 2
            , Css.width <| px s
            , Css.height <| px s
            , borderRadius <| px <| s / 2
            ]
    in
        div
            [ css
                [ left <| px 0
                , Css.width <| vw 100
                , Css.height <| vh 100
                , position fixed
                , overflow Css.hidden
                , Css.property "mix-blend-mode" <|
                    (lightness (colorsStr route).bg < 128)
                        => "lighten"
                        |= "darken"
                , opacity <| num 0.8
                , Css.property "pointer-events" "none"
                , zIndex <| int 16
                ]
            ]
            [ div
                [ css <|
                    [ backgroundColor (colors route).accent
                    , Css.property "pointer-events" "none"
                    ]
                        ++ pointerStyle size
                ]
                []
            , div
                [ css <|
                    [ backgroundColor (colors route).bg
                    , boxShadow4 (px 0) (px 0) (px 32) (colors route).primary
                    ]
                        ++ pointerStyle innerSize
                ]
                []
            ]
