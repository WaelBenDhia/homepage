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
import String exposing (slice)
import Guards exposing (..)
import Model exposing (Mdl)


navMenu : Mdl -> Html Msg
navMenu { route, target, interp } =
    let
        newLen =
            String.length >> Basics.toFloat >> (*) interp >> Basics.round

        newLenInverted =
            String.length >> Basics.toFloat >> (*) (1 - interp) >> Basics.round

        resize s =
            slice 0 (newLen s) s

        resizeInvert s =
            slice (newLenInverted s) (String.length s) s

        setSelected r =
            (route == r => buttonStyleSelected |= buttonStyleUnselected) route
    in
        div
            [ css
                [ displayFlex
                , flexDirection column
                , alignItems flexStart
                , position absolute
                , left <| px <| (16 * interp) - 16
                , bottom <| calc (vh 50) minus (px 224)
                , zIndex <| int 1
                ]
            ]
        <|
            List.map
                (\( r, t, w ) ->
                    a
                        [ css <| buttonStyle ++ setSelected r
                        , onClick <| GoTo r

                        -- , onMouseEnter <| MouseOver (Just r)
                        -- , onMouseLeave <| MouseOver Nothing
                        ]
                        [ text <|
                            (r == route => resizeInvert t)
                                |= (Just r == target => resize t)
                                |= t
                        ]
                )
                [ ( About, "About", 82 )
                , ( Education, "Education", 139 )
                , ( Work, "Work", 82 )
                , ( Skills, "Skills", 70 )
                ]


buttonStyle : List Style
buttonStyle =
    [ display inlineBlock
    , position relative
    , fontFamilies [ fonts.heading ]
    , fontSize <| px 32
    , Css.height <| px 48
    , lineHeight <| px 48
    , fontWeight <| int 700
    , padding2 (px 0) (px 8)
    , margin2 (px 32) (px 0)
    ]


buttonStyleSelected : Route -> List Style
buttonStyleSelected r =
    [ color (colors r).bg, backgroundColor (colors r).primary, paddingLeft <| px 24 ]


buttonStyleUnselected : Route -> List Style
buttonStyleUnselected r =
    [ color (colors r).fg, cursor pointer, hover [ color (colors r).primary ], paddingLeft <| px 24 ]
