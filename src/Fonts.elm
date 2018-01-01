module Fonts exposing (importNode, fonts)

import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import String exposing (..)


fonts : { arabic : String, body : String, heading : String }
fonts =
    { body = "Work Sans", heading = "Raleway", arabic = "Amiri" }


importNode : Html msg
importNode =
    let
        format =
            split " " >> join "+"

        fontLink =
            "@import url('https://fonts.googleapis.com/css?family="
                ++ format fonts.body
                ++ ":300,400|"
                ++ format fonts.heading
                ++ ":300,400,500|"
                ++ format fonts.arabic
                ++ "&subset=arabic');"
    in
        node "style" [ type_ "text/css" ] [ text fontLink ]
