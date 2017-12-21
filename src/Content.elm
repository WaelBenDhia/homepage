module Content exposing (content)

import Theming exposing (..)
import Fonts exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (class, css, type_)
import Css exposing (..)
import String exposing (..)
import List exposing (..)
import Routing exposing (..)


content : { a | interp : Float, route : Route } -> Html msg
content { route, interp } =
    let
        newLen =
            String.length >> Basics.toFloat >> (*) interp >> Basics.round

        resize s =
            slice 0 (newLen s) s
    in
        div [ css containerStyle ]
            [ div [ css gradientStyle ] []
            , div [ css contentStyle ] (splitParagraphs <| resize <| contentText route)
            ]


contentText : Route -> String
contentText route =
    case route of
        Home ->
            "This is the home page.\nWrite stuff here about yourself"

        Education ->
            "Write stuff here about your education.\nLike where you learned and shit."

        Work ->
            "Work.\nYour work experience"

        Skills ->
            "Things you can do."

        NotFound ->
            "You seem to be lost little lamb."


gradientStyle : List Style
gradientStyle =
    [ position absolute
    , backgroundImage <|
        linearGradient
            (stop <| hex "#000")
            (stop <| rgba 0 0 0 0)
            []
    , width <| pct 100
    , height <| px 64
    ]


containerStyle : List Style
containerStyle =
    [ position absolute
    , Css.left <| pct 25
    , top <| pct 25
    , width <| pct 60
    , height <| pct 75
    , property "mix-blend-mode" "lighten"
    ]


contentStyle : List Style
contentStyle =
    [ color colors.fg, width <| pct 100, height <| pct 100 ]


splitParagraphs : String -> List (Html msg)
splitParagraphs =
    lines >> List.map paragraph >> (::) (div [ css [ height <| px 32 ] ] [])


firstLetterStyle : Float -> List Style
firstLetterStyle size =
    [ fontSize <| px (1.8 * size)
    , padding <| px 4
    , paddingBottom <| px 0
    , fontFamilies [ fonts.heading ]
    , fontWeight <| int 700
    , color colors.bg
    , backgroundColor colors.primary
    , width <| px 16
    ]


paragraph : String -> Html msg
paragraph thing =
    case toList thing of
        l :: rest ->
            p
                [ css [ fontSize <| px 22, lineHeight <| px 32 ] ]
                [ span
                    [ css <| firstLetterStyle 22 ]
                    [ text <| fromChar l ]
                , text <| fromList rest
                ]

        [] ->
            p [] []
