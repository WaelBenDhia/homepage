module View exposing (view)

import Model exposing (Mdl, getInterp)
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
mainStyle ({ route } as mdl) =
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


view : Mdl -> Html Msg
view model =
    div
        [ css <| mainStyle model ]
    <|
        [ Pointer.pointer model, importNode, navMenu model ]
            ++ title model
            ++ [ Content.content model ]
