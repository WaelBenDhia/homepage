module View exposing (view)

import Model exposing (Mdl)
import Messages exposing (Msg)
import Html.Styled exposing (Html, div)
import Html.Styled.Attributes exposing (css)
import Css exposing (..)
import Fonts exposing (..)
import Theming exposing (colors)
import NavMenu exposing (navMenu)
import Title exposing (title)
import Content exposing (content)
import Pointer exposing (..)


mainStyle : Mdl -> List Style
mainStyle { route, interp } =
    [ fontFamilies [ fonts.body ]
    , backgroundColor (colors route).bg
    , width <| calc (pct 100) minus (px <| 16 * interp)
    , height <| pct 100
    , borderLeft3 (px <| 16 * interp) solid (colors route).primary
    ]


view : Mdl -> Html Msg
view model =
    div
        [ css <| mainStyle model ]
    <|
        [ Pointer.pointer model, importNode, navMenu model ]
            ++ title model
            ++ [ Content.content model ]
