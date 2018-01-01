module Title exposing (title)

import Routing exposing (..)
import Theming exposing (..)
import Fonts exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (class, css, type_)
import Css exposing (..)
import String exposing (length, slice)
import List exposing (intersperse)
import Model exposing (Mdl, getInterp)


title : Mdl -> List (Html msg)
title ({ route } as mdl) =
    let
        col =
            colors route

        newLen =
            length >> toFloat >> ((*) <| getInterp mdl) >> Basics.round

        resize s =
            slice 0 (newLen s) s

        ( textEn, textAr ) =
            case route of
                About ->
                    ( "Wael Ben Dhia", "وَائِلْ بِنْ ضِياءْ" )

                Education ->
                    ( "Education", "تَعْلِيمْ" )

                Work ->
                    ( "Work", "عَمَلْ" )

                Skills ->
                    ( "Skills", "مَهَارَاتْ" )

                NotFound ->
                    ( "404", "٤٠٤" )

        containerEn =
            [ position absolute
            , Css.left <| pct 12.5
            , top <| pct 12.5
            , zIndex <| int 1
            , after
                [ Css.property "content" "''"
                , position absolute
                , Css.left <| px -16
                , top <| px -16
                , backgroundColor col.primary
                , Css.width <| calc (pct 100) minus (px 8)
                , Css.height <| pct 80
                , zIndex <| int -1
                ]
            ]

        containerAr =
            [ position absolute
            , Css.right <| pct 6.7
            , top <| pct 2
            , zIndex <| int 0
            ]

        styleAr =
            [ fontWeight <| int 500
            , fontSize <| vw 16
            , fontFamilies [ fonts.arabic ]
            , color col.accent
            ]

        styleEn =
            [ fontWeight <| int 500
            , fontSize <| px 80
            , fontFamilies [ fonts.heading ]
            , color col.fg
            , zIndex <| int 1
            , padding <| px 8
            , paddingBottom <| px 0
            ]

        transform ( t, style, cStyle ) =
            div [ css cStyle ] [ span [ css style ] [ text <| resize t ] ]
    in
        List.map
            transform
            [ ( textEn, styleEn, containerEn )
            , ( textAr, styleAr, containerAr )
            ]
