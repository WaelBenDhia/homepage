module View exposing (view)

import Model exposing (Mdl)
import Messages exposing (Msg)
import Html.Styled exposing (Html, div)
import Html.Styled.Attributes exposing (css)
import Css exposing (..)
import Fonts exposing (..)
import Theming exposing (colors)
import NavMenu exposing (navMenu)
import Pointer exposing (pointer)
import Title exposing (title)
import Content exposing (content)


mainStyle : List Style
mainStyle =
    [ fontFamilies [ fonts.body ]
    , backgroundColor colors.bg
    , width <| pct 100
    , height <| pct 100
    ]


view : Mdl -> Html Msg
view model =
    div
        [ css mainStyle ]
    <|
        List.concat
            [ [ Pointer.pointer model, importNode, navMenu model ]
            , title model
            , [ Content.content model ]
            ]
