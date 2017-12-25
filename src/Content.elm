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


content : Mdl -> Html msg
content { route, interp } =
    let
        newLen =
            String.length >> Basics.toFloat >> (*) interp >> Basics.round

        resize s =
            slice 0 (newLen s) s

        paragraphs =
            route |> contentText |> resize |> splitParagraphs
    in
        div [ css containerStyle ]
            [ div [ css gradientStyle ] []
            , div [ css contentStyle ] paragraphs
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


gradientStyle : List Style
gradientStyle =
    [ position fixed
    , backgroundImage <|
        linearGradient
            (stop <| hex "#000")
            (stop <| rgba 0 0 0 0)
            []
    , width <| vw 60
    , height <| px 64
    , Css.left <| vw 25
    , after
        [ property "content" "''"
        , position fixed
        , backgroundColor <| hex "#000"
        , width <| vw 60
        , Css.left <| vw 25
        , height <| vh 30
        , top <| px 0
        ]
    ]


contentStyle : List Style
contentStyle =
    [ color colors.fg, width <| pct 100, height <| pct 100 ]


containerStyle : List Style
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
    , property "mix-blend-mode" "lighten"
    ]


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
