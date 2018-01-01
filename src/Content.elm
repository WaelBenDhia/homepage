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

        style =
            [ position absolute
            , Css.left <| px 0
            , top <| px 0
            , width <| pct 60
            , height <| vh 70
            , paddingLeft <| pct 25
            , paddingRight <| pct 15
            , paddingTop <| vh 30
            , overflow <| auto
            , zIndex <| int 1
            , property "mix-blend-mode" <|
                if lightness (colorsStr route).bg < 128 then
                    "lighten"
                else
                    "darken"
            ]
    in
        div [ css style ]
            [ shadower mdl
            , contentDiv mdl
            , contentBorder True mdl
            , contentBorder False mdl
            ]


contentBorder : Bool -> Mdl -> Html msg
contentBorder vertical ({ route } as mdl) =
    let
        col =
            colors route

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


shadower : Mdl -> Html msg
shadower ({ route } as mdl) =
    let
        col =
            colors route

        style =
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
    in
        div [ css style ] []


contentDiv : Mdl -> Html msg
contentDiv ({ route } as mdl) =
    let
        col =
            colors route

        newLen =
            length >> Basics.toFloat >> (*) (getInterp mdl) >> Basics.round

        resize s =
            slice 0 (newLen s) s

        splitParagraphs =
            lines
                >> List.map (formatParagraph mdl)
                >> (::) (div [ css [ height <| px 32 ] ] [])
    in
        div [ css [ color col.fg, width <| pct 100, height <| pct 100 ] ]
            (splitParagraphs <| resize <| contentText route)


formatParagraph : Mdl -> String -> Html msg
formatParagraph { route } thing =
    let
        col =
            colors route

        firstLetterStyle =
            [ fontSize <| px 33
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
                , backgroundColor col.primary
                , Css.width <| pct 70
                , Css.height <| pct 80
                , zIndex <| int -1
                ]
            , color col.fg
            , width <| px 16
            ]

        ( fLet, pg ) =
            case toList thing of
                l :: rest ->
                    ( fromChar l, fromList rest )

                [] ->
                    ( "", "" )
    in
        p
            [ css [ fontSize <| px 22, lineHeight <| px 32 ] ]
            [ span
                [ css firstLetterStyle ]
                [ text fLet ]
            , text pg
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
