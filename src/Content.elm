module Content exposing (content)

import Fonts exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (class, css, type_)
import Css exposing (..)
import String exposing (..)
import List exposing (..)


content : String -> Html msg
content contentText =
    div [ css contentStyle ] <| splitParagraphs contentText


contentStyle : List Style
contentStyle =
    [ position absolute
    , Css.left (pct 25)
    , top (pct 25)
    , width (pct 60)
    , height (pct 75)
    , color (hex "#fff")
    , overflowY scroll
    ]


splitParagraphs : String -> List (Html msg)
splitParagraphs contentText =
    List.map paragraph <| split "\n" contentText


firstLetterStyle : List Style
firstLetterStyle =
    [ fontSize <| Css.em 1.8
    , padding <| px 4
    , fontFamilies [ fonts.heading ]
    , fontWeight <| int 700
    , color <| hex "#000"
    , backgroundColor <| hex "#ff0"
    , width <| px 16
    ]


paragraph : String -> Html msg
paragraph thing =
    case toList thing of
        l :: rest ->
            p
                []
                [ span
                    [ css firstLetterStyle ]
                    [ text <| fromChar l ]
                , text <| fromList rest
                ]

        [] ->
            p [] []
