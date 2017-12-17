module Fonts exposing (importNode, fonts)

import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)


importNode : Html msg
importNode =
    node "style" [ type_ "text/css" ] [ text fontLink ]


fontLink : String
fontLink =
    "@import url('https://fonts.googleapis.com/css?family=Montserrat:300,400|Zilla+Slab:300,700|Amiri&subset=arabic');"


fonts : { arabic : String, body : String, heading : String }
fonts =
    { body = "Montserrat"
    , heading = "Zilla Zlab"
    , arabic = "Amiri"
    }
