module Fonts exposing (importNode, fonts)

import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import String exposing (..)


importNode : Html msg
importNode =
    node "style" [ type_ "text/css" ] [ text fontLink ]


fonts : { arabic : String, body : String, heading : String }
fonts =
    { body = "Montserrat"
    , heading = "Josefin Slab"
    , arabic = "Amiri"
    }


fontLink : String
fontLink =
    let
        replace org rep tar =
            split org tar |> join rep

        format =
            replace " " "+"
    in
        concat
            [ "@import url('https://fonts.googleapis.com/css?family="
            , format fonts.body
            , ":300,400|"
            , format fonts.heading
            , ":400,700,900|"
            , format fonts.arabic
            , "&subset=arabic');"
            ]
