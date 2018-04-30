module Pointer exposing (pointerContainer)

import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Maybe exposing (andThen, withDefault)
import Model exposing (..)
import Theming exposing (..)
import Tuple exposing (first, second)


pointerContainer : Mdl -> Html msg
pointerContainer { mousePosition, route, mouseOver, target } =
    let
        size =
            mouseOver
                |> andThen (\( _, i ) -> Just <| sqrt (toFloat i ^ 2 + 48 ^ 2))
                |> withDefault
                    (target |> andThen (Just << always 96) |> withDefault 32)

        innerSize =
            if target == Nothing then
                0
            else
                size

        pointerStyle s =
            [ position absolute
            , mouseOver
                |> andThen (second >> toFloat >> flip (/) 2 >> (+) 20 >> Just)
                |> withDefault (toFloat mousePosition.x)
                |> px
                |> left
            , mouseOver
                |> andThen
                    (Tuple.first
                        >> toFloat
                        >> (*) 112
                        >> (-) 168
                        >> px
                        >> calc (vh 50) minus
                        >> top
                        >> Just
                    )
                |> withDefault
                    (top <| px <| toFloat mousePosition.y)
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
