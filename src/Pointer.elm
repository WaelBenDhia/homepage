module Pointer exposing (pointer)

import Model exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Css exposing (..)
import Theming exposing (..)


pointer : Mdl -> Html msg
pointer { mousePosition, interp, route } =
    let
        size =
            48

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
                [ Css.width <| vw 100
                , Css.height <| vw 100
                , position fixed
                , overflow Css.hidden
                , Css.property "mix-blend-mode" "exclusion"
                , Css.property "pointer-events" "none"
                , zIndex <| int 16
                ]
            ]
            [ div
                [ css <|
                    [ backgroundColor (colors route).primary
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
