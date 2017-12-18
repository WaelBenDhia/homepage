module Title exposing (title)

import Routing exposing (..)
import Theming exposing (..)
import Fonts exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (class, css, type_)
import Css exposing (..)
import String exposing (..)
import List exposing (..)


pageTitle : Route -> ( String, String )
pageTitle route =
    case route of
        Home ->
            ( "Wael Ben Dhia", "وائِلْ بِنْ ضِياءْ" )

        Education ->
            ( "Education", "تَعْليم" )

        Work ->
            ( "Work", "عَمَل" )

        Skills ->
            ( "Skills", "مَهارات" )

        NotFound ->
            ( "404", "٤٠٤" )


zip : List a -> List b -> List ( a, b )
zip xs ys =
    case ( xs, ys ) of
        ( x :: xBack, y :: yBack ) ->
            ( x, y ) :: zip xBack yBack

        ( _, _ ) ->
            []


title : Route -> Float -> List (Html msg)
title route interpolator =
    let
        newLen s =
            Basics.round <| (Basics.toFloat <| String.length s) * interpolator

        resize s =
            slice 0 (newLen s) s

        ( titleEn, titleAr ) =
            pageTitle route
    in
        List.map
            (\( t, style, cStyle ) ->
                t
                    |> resize
                    |> String.words
                    |> intersperse " "
                    |> List.map (\x -> span [ css style ] [ text x ])
                    |> div [ css cStyle ]
            )
            [ ( titleEn, titleStyle, titleContainerStyle ), ( titleAr, decoStyle, decoContainerStyle ) ]


styleBase : FontSize a -> String -> List Style
styleBase size font =
    [ fontWeight (int 300)
    , fontSize size
    , fontFamilies [ font ]
    ]


decoStyle : List Style
decoStyle =
    (styleBase (vw 16) fonts.arabic) ++ [ color colors.accent ]


decoContainerStyle : List Style
decoContainerStyle =
    [ position absolute
    , Css.right <| pct 6.7
    , top <| pct 2
    , zIndex <| int 0
    ]


textShadow shadowWidth color =
    let
        interval =
            List.range -shadowWidth shadowWidth

        allPairs =
            List.filter (\( x, y ) -> x /= 0 || y /= 0) <|
                zip
                    (List.concat <| List.repeat (List.length interval) interval)
                    (List.concatMap (List.repeat <| List.length interval) interval)

        colored =
            List.map
                (\( x, y ) ->
                    String.concat <| intersperse "px " [ toString x, toString y, color ]
                )
                allPairs
    in
        String.join ", " colored


titleStyle : List Style
titleStyle =
    (++)
        (styleBase (px 80) fonts.heading)
        [ color colors.bg
        , zIndex <| int 1
        , backgroundColor colors.primary
        , padding <| px 8
        , paddingBottom <| px 0
        ]


titleContainerStyle : List Style
titleContainerStyle =
    [ position absolute
    , Css.left <| pct 12.5
    , top <| pct 12.5
    , zIndex <| int 1
    ]



-- , after
-- [ property "content" "''"
-- , position absolute
-- , width <| pct 100
-- , height <| px 4
-- , backgroundColor colors.primary
-- , Css.left <| px 0
-- , bottom <| px 14
-- , zIndex <| int -1
-- ]
