module Title exposing (title)

import Fonts exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (class, css, type_)
import Css exposing (..)


title : ( String, String ) -> List (Html msg)
title ( titleEn, titleAr ) =
    [ span [ css titleStyle ] [ text titleEn ]
    , span [ css decoStyle ] [ text titleAr ]
    ]


styleBase : FontSize a -> String -> List Style
styleBase size font =
    [ fontWeight (int 300)
    , fontSize size
    , fontFamilies [ font ]
    , position absolute
    ]


decoStyle : List Style
decoStyle =
    (++)
        (styleBase (vw 16) fonts.arabic)
        [ color <| rgb 24 24 24
        , right <| pct 6.7
        , top <| pct 2
        , zIndex <| int 0
        ]


titleStyle : List Style
titleStyle =
    (++)
        (styleBase (px 80) fonts.heading)
        [ color <| hex "#fff"
        , property "text-shadow" "1px 1px #000,-1px 1px #000,1px -1px #000,-1px -1px #000"
        , left <| pct 12.5
        , top <| pct 12.5
        , zIndex <| int 1
        , after
            [ property "content" "''"
            , position absolute
            , width <| pct 100
            , height <| px 4
            , backgroundColor <| hex "#ff0"
            , left <| px 0
            , bottom <| px 14
            , zIndex <| int -1
            ]
        ]
