module Theming exposing (..)

import Css exposing (..)
import String exposing (..)
import Char exposing (..)
import Guards exposing (..)
import Routing exposing (..)


colors : Route -> { accent : Color, bg : Color, fg : Color, primary : Color }
colors r =
    let
        cStr =
            colorsStr r

        ( col1, col2 ) =
            ( cStr.primary, getAccent cStr.primary )

        ( lighter, darker ) =
            lightness col1
                > lightness col2
                => ( col1, col2 )
                |= ( col2, col1 )

        ( primary, accent ) =
            (lightness cStr.bg < 128)
                => ( lighter, darker )
                |= ( darker, lighter )
    in
        { primary = hex primary
        , bg = hex cStr.bg
        , fg = hex <| invert cStr.bg
        , accent = hex accent
        }


colorsStr : Route -> { bg : String, primary : String }
colorsStr r =
    { primary =
        (case r of
            About ->
                "#f00"

            Education ->
                "#4464ad"

            Work ->
                "#ffba08"

            Skills ->
                "#55f"

            NotFound ->
                "#dd7373"
        )
    , bg = "#fff"
    }


getAccent : String -> String
getAccent primary =
    let
        ( r, g, b ) =
            toRGB primary
    in
        fromRGB ( 255 - g, 255 - b, 255 - r )


fromRGB : ( Int, Int, Int ) -> String
fromRGB ( r, g, b ) =
    let
        dHex n =
            [ toHex (n // 16), toHex (n % 16) ]
    in
        fromList <| '#' :: dHex r ++ dHex g ++ dHex b


toRGB : String -> ( Int, Int, Int )
toRGB hex =
    let
        col =
            (length hex == 4 || length hex == 7)
                => (dropLeft 1 hex)
                |= hex

        mult_ c =
            fromHex c * 17

        mult c1 c2 =
            (fromHex c1) * 16 + fromHex c2
    in
        case toList col of
            [ r, g, b ] ->
                ( mult_ r, mult_ g, mult_ b )

            [ r1, r2, g1, g2, b1, b2 ] ->
                ( mult r1 r2, mult g1 g2, mult b1 b2 )

            _ ->
                ( 0, 0, 0 )


lightness : String -> Float
lightness hex =
    let
        ( r, g, b ) =
            toRGB hex
    in
        (Basics.toFloat (r + g + b)) / 3


invert : String -> String
invert hex =
    let
        ( r, g, b ) =
            toRGB hex
    in
        fromRGB ( 255 - r, 255 - g, 255 - b )


fromHex : Char -> Int
fromHex c =
    let
        code =
            toCode <| Char.toLower c
    in
        (code < toCode '0' => 0)
            |= (code < toCode 'a' => code - toCode '0')
            |= (code < toCode 'f' => code - toCode 'a')
            |= 15


toHex : Int -> Char
toHex n =
    (n < 0 => '0')
        |= (n < 10 => fromCode (toCode '0' + n))
        |= (n < 16 => fromCode (toCode 'a' + (n - 10)))
        |= 'f'
