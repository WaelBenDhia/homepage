module NavMenu exposing (..)

import Css exposing (..)
import Fonts exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Html.Styled.Events exposing (..)
import List
import Messages exposing (..)
import Model exposing (Mdl, getInterp)
import Routing exposing (..)
import String exposing (length, slice)
import Theming exposing (..)


navMenu : Mdl -> Html Msg
navMenu ({ route, target } as mdl) =
    let
        style =
            [ displayFlex
            , flexDirection column
            , alignItems flexStart
            , position absolute
            , left <| px <| (8 * getInterp mdl) - 8
            , top <| calc (vh 50) minus (px 224)
            , zIndex <| int 2
            ]
    in
    div [ css style ] <|
        List.map
            (toButton mdl)
            [ ( About, "About", 82, ( 0, 90 ) )
            , ( Education, "Education", 139, ( 1, 154 ) )
            , ( Work, "Work", 82, ( 2, 86 ) )
            , ( Skills, "Skills", 70, ( 3, 82 ) )
            ]


toButton : Mdl -> ( Route, String, a, ( Int, Int ) ) -> Html Msg
toButton ({ route, target } as mdl) ( r, t, w, offset ) =
    let
        col =
            colors route

        routeThen val def =
            if route == r then
                val
            else
                def

        newLen inv =
            length
                >> toFloat
                >> (*)
                    (if inv then
                        1 - getInterp mdl
                     else
                        getInterp mdl
                    )
                >> Basics.round

        resize inv s =
            slice
                (if inv then
                    newLen True s
                 else
                    0
                )
                (if inv then
                    length s
                 else
                    newLen False s
                )
                s

        baseStyle =
            [ display inlineBlock
            , position relative
            , fontFamilies [ fonts.heading ]
            , fontSize <| px 32
            , Css.height <| px 48
            , lineHeight <| px 48
            , fontWeight <| int 300
            , padding2 (px 0) (px 8)
            , margin2 (px 32) (px 0)
            ]

        curStyle =
            [ color col.fg
            , after
                [ Css.property "content" "''"
                , position absolute
                , left <| px 0
                , bottom <| px 0
                , backgroundColor col.primary
                , Css.width <| pct 100
                , Css.height <| pct 40
                , zIndex <| int -1
                ]
            , paddingLeft <| px 16
            ]

        notCurStyle =
            [ color col.fg
            , cursor pointer
            , hover [ color col.primary ]
            , paddingLeft <| px 24
            ]
    in
    a
        [ css <| baseStyle ++ routeThen curStyle notCurStyle
        , onClick <| GoTo r
        , onMouseEnter <| MouseOver <| routeThen Nothing <| Just offset
        , onMouseLeave <| MouseOver Nothing
        ]
        [ text <|
            if r == route || Just r == target then
                resize (r == route) t
            else
                t
        ]
