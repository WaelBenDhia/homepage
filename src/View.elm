module View exposing (view)

import Content exposing (content)
import Css exposing (..)
import Fonts exposing (..)
import Html.Styled exposing (Html, div)
import Html.Styled.Attributes exposing (css)
import Messages exposing (Msg)
import Model exposing (Mdl, getInterp)
import NavMenu exposing (navMenu)
import Pointer exposing (..)
import Theming exposing (..)
import Title exposing (title)


view : Mdl -> Html Msg
view ({ route } as mdl) =
    div
        [ css <|
            let
                borderWidth =
                    px <| 8 * getInterp mdl
            in
                [ fontFamilies [ fonts.body ]
                , backgroundColor (colors route).bg
                , width <| calc (pct 100) minus borderWidth
                , height <| pct 100
                , borderLeft3 borderWidth solid (colors route).primary
                ]
        ]
    <|
        pointerContainer mdl
            :: importNode
            :: navMenu mdl
            :: Content.content mdl
            :: title mdl
