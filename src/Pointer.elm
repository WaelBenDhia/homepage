module Pointer exposing (pointer)

import Model exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Css exposing (..)
import Theming exposing (..)


pointer : Mdl -> Html msg
pointer { mousePosition, interp } =
    let
        size =
            48

        innerSize =
            (1 - interp) * size
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
                [ css
                    [ position absolute
                    , left <| px <| (toFloat mousePosition.x) - size / 2
                    , top <| px <| (toFloat mousePosition.y) - size / 2
                    , Css.width <| px size
                    , Css.height <| px size
                    , borderRadius <| px <| size / 2
                    , backgroundColor colors.primary
                    , Css.property "pointer-events" "none"
                    ]
                ]
                []
            , div
                [ css
                    [ position absolute
                    , left <| px <| (toFloat mousePosition.x) - innerSize / 2
                    , top <| px <| (toFloat mousePosition.y) - innerSize / 2
                    , Css.width <| px innerSize
                    , Css.height <| px innerSize
                    , borderRadius <| px <| innerSize / 2
                    , backgroundColor colors.bg
                    , boxShadow4 (px 0) (px 0) (px 32) colors.primary
                    ]
                ]
                []
            ]
