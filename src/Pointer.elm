module Pointer exposing (pointer)

import Model exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Css exposing (..)
import Theming exposing (..)


pointer : Mdl -> Html msg
pointer { mousePosition, route, mouseOver, target } =
    let
        size =
            case mouseOver of
                Nothing ->
                    if target == Nothing then
                        32
                    else
                        96

                Just ( _, i ) ->
                    sqrt ((toFloat i) ^ 2 + 48 ^ 2)

        innerSize =
            if target == Nothing then
                0
            else
                size

        pointerStyle s =
            [ position absolute
            , left <|
                px <|
                    case mouseOver of
                        Just ( _, i ) ->
                            (toFloat i) / 2 + 20

                        Nothing ->
                            toFloat mousePosition.x
            , case mouseOver of
                Just ( i, _ ) ->
                    top <| calc (vh 50) minus (px <| 168 - (toFloat i) * 112)

                Nothing ->
                    top <| px <| (toFloat mousePosition.y)
            , Css.width <| px s
            , Css.height <| px s
            , borderRadius <| px <| s / 2
            , Css.property "transform" "translate(-50%, -50%)"
            , Css.property "transition-property" "width, height, border-radius"
            , Css.property "transition-duration" "0.4s"
            , Css.property "transition-timing-function" "ease"
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
                    if lightness (colorsStr route).bg < 128 then
                        "lighten"
                    else
                        "darken"
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
