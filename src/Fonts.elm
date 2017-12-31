module Fonts exposing (importNode, fonts)

import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import String exposing (..)


importNode : Html msg
importNode =
    node "style" [ type_ "text/css" ] [ text fontLink ]


fonts : { arabic : String, body : String, heading : String }
fonts =
    { body = "Hind"
    , heading = "Montserrat"
    , arabic = "Amiri"
    }


fontLink : String
fontLink =
    let
        format =
            split " " >> join "+"
    in
        concat
            [ "@import url('https://fonts.googleapis.com/css?family="
            , format fonts.body
            , ":300,400|"
            , format fonts.heading
            , ":300,400,500|"
            , format fonts.arabic
            , "&subset=arabic');"
            ]
