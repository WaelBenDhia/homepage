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
            ( "Wael Ben Dhia", "وَائِلْ بِنْ ضِياءْ" )

        Education ->
            ( "Education", "تَعْليمْ" )

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


title : Route -> Float -> List (Html msg)
title route interpolator =
    let
        newLen =
            String.length >> Basics.toFloat >> (*) interpolator >> Basics.round

        resize s =
            slice 0 (newLen s) s

        ( titleEn, titleAr ) =
            pageTitle route
    in
        List.map
            (\( t, style, cStyle ) ->
                if String.length t > 0 then
                    t
                        |> String.words
                        |> intersperse " "
                        |> List.map (\x -> span [ css style ] [ text x ])
                        |> div [ css cStyle ]
                else
                    div [] []
            )
            [ ( resize titleEn, titleStyle, titleContainerStyle ), ( resize titleAr, decoStyle, decoContainerStyle ) ]


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
    , property "mix-blend-mode" "lighten"
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
