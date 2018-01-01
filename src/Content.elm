module Content exposing (content)

import Theming exposing (..)
import Fonts exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (class, css, type_)
import Css exposing (..)
import String exposing (..)
import List
import Routing exposing (..)
import Model exposing (Mdl, getInterp)
import Theming exposing (..)


content : Mdl -> Html msg
content ({ route } as mdl) =
    let
        col =
            colors route

        newLen =
            Basics.round << (*) (getInterp mdl) << Basics.toFloat << length

        resize s =
            slice 0 (newLen s) s

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
            , property "mix-blend-mode" <|
                if lightness (colorsStr route).bg < 128 then
                    "lighten"
                else
                    "darken"
            ]

        border vertical =
            let
                vertThen val def =
                    if vertical then
                        val
                    else
                        def
            in
                div
                    [ css
                        [ position fixed
                        , Css.right <| calc (pct 15) plus (px <| vertThen 16 48)
                        , top <| calc (vh 30) plus (px <| vertThen 48 16)
                        , vertThen (width <| px 8) (width <| vw 25)
                        , vertThen (height <| vh 25) (height <| px 8)
                        , backgroundColor col.primary
                        , zIndex <| int 2
                        ]
                    ]
                    []

        content =
            div [ css [ color col.fg, width <| pct 100, height <| pct 100 ] ]
                (splitParagraphs route <| resize <| contentText route)

        shadower =
            div
                [ css
                    [ position fixed
                    , backgroundImage <|
                        linearGradient (stop col.bg) (stop <| rgba 0 0 0 0) []
                    , width <| vw 60
                    , height <| px 64
                    , Css.left <| vw 25
                    , zIndex <| int 1
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
                ]
                []
    in
        div [ css containerStyle ]
            [ shadower, content, border True, border False ]


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
    , position relative
    , padding <| px 4
    , paddingBottom <| px 0
    , fontFamilies [ fonts.heading ]
    , fontWeight <| int 500
    , after
        [ Css.property "content" "''"
        , position absolute
        , Css.left <| px 0
        , top <| px 0
        , backgroundColor (colors r).primary
        , Css.width <| pct 70
        , Css.height <| pct 80
        , zIndex <| int -1
        ]
    , color (colors r).fg
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
