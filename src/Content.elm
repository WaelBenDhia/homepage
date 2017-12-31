module Content exposing (content)

import Theming exposing (..)
import Fonts exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (class, css, type_)
import Css exposing (..)
import String exposing (..)
import List exposing (..)
import Routing exposing (..)
import Model exposing (Mdl)
import Theming exposing (..)
import Guards exposing (..)


content : Mdl -> Html msg
content { route, interp } =
    let
        col =
            colors route

        newLen =
            String.length >> Basics.toFloat >> (*) interp >> Basics.round

        resize s =
            slice 0 (newLen s) s

        paragraphs =
            route |> contentText |> resize |> splitParagraphs route

        containerStyle =
            [ position absolute
            , Css.left <| px 0
            , top <| px 0
            , width <| pct 60
            , height <| vh 70
            , paddingLeft <| pct 25
            , paddingRight <| pct 15
            , paddingTop <| vh 30
            , overflow <| auto
            , property "mix-blend-mode"
                (lightness (colorsStr route).bg < 128 => "lighten" |= "darken")
            ]

        borderStyle vertical =
            [ position fixed
            , Css.right <| calc (pct 15) plus (px <| vertical => 16 |= 32)
            , top <| calc (vh 30) plus (px <| vertical => 32 |= 16)
            , vertical => (width <| px 8) |= (width <| vw 25)
            , vertical => (height <| vh 25) |= (height <| px 8)
            , backgroundColor col.primary
            ]

        contentStyle =
            [ color col.fg, width <| pct 100, height <| pct 100 ]

        gradientStyle =
            [ position fixed
            , backgroundImage <|
                linearGradient
                    (stop col.bg)
                    (stop <| rgba 0 0 0 0)
                    []
            , width <| vw 60
            , height <| px 64
            , Css.left <| vw 25
            , after
                [ property "content" "''"
                , position fixed
                , backgroundColor col.bg
                , width <| vw 60
                , Css.left <| vw 25
                , height <| vh 30
                , top <| px 0
                ]
            ]
    in
        div [ css <| containerStyle ]
            [ div [ css <| gradientStyle ] []
            , div [ css <| contentStyle ] paragraphs
            , div [ css <| borderStyle True ] []
            , div [ css <| borderStyle False ] []
            ]


contentText : Route -> String
contentText route =
    case route of
        About ->
            "This is the home page.\nWrite stuff here about yourself"

        Education ->
            "Write stuff here about your education.\nLike where you learned and shit."

        Work ->
            String.join "\n"
                [ "Work.\nYour work experience"
                , "Work.\nYour work experience"
                , "Work.\nYour work experience"
                , "Work.\nYour work experience"
                , "Work.\nYour work experience"
                , "Work.\nYour work experience"
                , "Work.\nYour work experience"
                , "Work.\nYour work experience"
                , "Work.\nYour work experience"
                , "Work.\nYour work experience"
                , "Work.\nYour work experience"
                , "Work.\nYour work experience"
                , "Work.\nYour work experience"
                , "Work.\nYour work experience"
                , "Work.\nYour work experience"
                , "Work.\nYour work experience"
                ]

        Skills ->
            "Things you can do."

        NotFound ->
            "You seem to be lost little lamb."


splitParagraphs : Route -> String -> List (Html msg)
splitParagraphs r =
    lines >> List.map (paragraph r) >> (::) (div [ css [ height <| px 32 ] ] [])


firstLetterStyle : Route -> Float -> List Style
firstLetterStyle r size =
    [ fontSize <| px (1.8 * size)
    , padding <| px 4
    , paddingBottom <| px 0
    , fontFamilies [ fonts.heading ]
    , fontWeight <| int 700
    , color (colors r).bg
    , backgroundColor (colors r).primary
    , width <| px 16
    ]


paragraph : Route -> String -> Html msg
paragraph r thing =
    case toList thing of
        l :: rest ->
            p
                [ css [ fontSize <| px 22, lineHeight <| px 32 ] ]
                [ span
                    [ css <| firstLetterStyle r 22 ]
                    [ text <| fromChar l ]
                , text <| fromList rest
                ]

        [] ->
            p [] []
