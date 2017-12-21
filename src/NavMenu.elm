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


navMenu : { a | interp : Float, route : Route, target : Maybe Route } -> Html Msg
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
            if route == r then
                buttonStyleSelected
            else
                buttonStyleUnselected
    in
        div
            [ css
                [ displayFlex
                , flexDirection column
                , alignItems flexStart
                , position absolute
                , left <| px 0
                , bottom <| px 0
                ]
            ]
        <|
            List.map
                (\( r, t, w ) ->
                    a
                        [ css <| buttonStyle
                        , css <| setSelected r
                        , onClick <| GoTo r
                        ]
                        [ text <|
                            (if r == route then
                                resizeInvert t
                             else if Just r == target then
                                resize t
                             else
                                t
                            )
                        ]
                )
                [ ( Home, "Home", 82 )
                , ( Education, "Education", 139 )
                , ( Work, "Work", 82 )
                , ( Skills, "Skills", 70 )
                ]


buttonStyle =
    [ display inlineBlock
    , position relative
    , fontFamilies [ fonts.heading ]
    , fontSize <| px 32
    , Css.height <| px 48
    , lineHeight <| px 48
    , fontWeight <| int 700
    , padding2 (px 0) (px 8)
    ]


buttonStyleSelected =
    [ color colors.bg
    , backgroundColor colors.primary
    ]


buttonStyleUnselected =
    [ color colors.fg
    , cursor pointer
    , hover [ color colors.primary ]
    ]
