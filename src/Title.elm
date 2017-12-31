module Title exposing (title)

import Routing exposing (..)
import Theming exposing (..)
import Fonts exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (class, css, type_)
import Css exposing (..)
import String exposing (..)
import List exposing (..)
import Guards exposing (..)
import Model exposing (Mdl)


pageTitle : Route -> ( String, String )
pageTitle route =
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


zip : List a -> List b -> List ( a, b )
zip xs ys =
    case ( xs, ys ) of
        ( x :: xBack, y :: yBack ) ->
            ( x, y ) :: zip xBack yBack

        ( _, _ ) ->
            []


title : Mdl -> List (Html msg)
title { route, interp } =
    let
        newLen =
            String.length >> Basics.toFloat >> (*) interp >> Basics.round

        resize s =
            slice 0 (newLen s) s

        ( titleEn, titleAr ) =
            pageTitle route
    in
        List.map
            (\( t, style, cStyle ) ->
                div [ css cStyle ] [ span [ css style ] [ text t ] ]
            )
            [ ( resize titleEn, titleStyle route, titleContainerStyle route )
            , ( resize titleAr, decoStyle route, decoContainerStyle )
            ]


styleBase : FontSize a -> String -> List Style
styleBase size font =
    [ fontWeight <| int 500
    , fontSize size
    , fontFamilies [ font ]
    ]


decoStyle : Route -> List Style
decoStyle r =
    (styleBase (vw 16) fonts.arabic) ++ [ color (colors r).accent ]


decoContainerStyle : List Style
decoContainerStyle =
    [ position absolute
    , Css.right <| pct 6.7
    , top <| pct 2
    , zIndex <| int 0
    ]


textShadow : Int -> String -> String
textShadow shadowWidth color =
    let
        interval =
            List.range -shadowWidth shadowWidth

        len =
            List.length interval

        allPairs =
            zip
                (interval |> List.repeat len |> List.concat)
                (interval |> List.concatMap (List.repeat len))

        colored =
            List.map
                (\( x, y ) ->
                    String.concat <| intersperse "px " [ toString x, toString y, color ]
                )
                allPairs
    in
        String.join ", " colored


titleStyle : Route -> List Style
titleStyle r =
    (++)
        (styleBase (px 80) fonts.heading)
        [ color (colors r).fg
        , zIndex <| int 1

        -- , backgroundColor (colors r).primary
        , padding <| px 8
        , paddingBottom <| px 0
        ]


titleContainerStyle : Route -> List Style
titleContainerStyle r =
    [ position absolute
    , Css.left <| pct 12.5
    , top <| pct 12.5
    , zIndex <| int 1
    , after
        [ Css.property "content" "''"
        , position absolute
        , Css.left <| px -16
        , top <| px -16
        , backgroundColor (colors r).primary
        , Css.width <| calc (pct 100) minus (px 8)
        , Css.height <| pct 80
        , zIndex <| int -1
        ]
    ]
