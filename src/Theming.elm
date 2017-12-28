module Theming exposing (..)

import Css exposing (..)
import String exposing (..)
import Char
import Guards exposing (..)
import Routing exposing (..)


colors : Route -> { accent : Color, bg : Color, fg : Color, primary : Color }
colors r =
    let
        cStr =
            colorsStr r
    in
        { primary = hex cStr.primary
        , bg = hex cStr.bg
        , fg = hex <| invert cStr.bg
        , accent = hex <| getAccent cStr.primary
        }


colorsStr : Route -> { bg : String, primary : String }
colorsStr r =
    { primary =
        (case r of
            About ->
                "#f00"

            Education ->
                "#880"

            Work ->
                "#0f0"

            Skills ->
                "#088"

            _ ->
                "#00f"
        )
    , bg = "#fff"
    }


getAccent : String -> String
getAccent primary =
    let
        ( r, g, b ) =
            toRGB primary
    in
        fromRGB ( b + r, g + r, b + g )


fromRGB : ( Int, Int, Int ) -> String
fromRGB ( r, g, b ) =
    let
        dHex n =
            [ toHex ((n % 256) // 16), toHex (n % 16) ]
    in
        fromList <| '#' :: dHex r ++ dHex g ++ dHex b


toRGB : String -> ( Int, Int, Int )
toRGB hex =
    let
        col =
            (length hex == 4 || length hex == 7)
                => (dropLeft 1 hex)
                |= hex

        col_ =
            toList
                ((length col == 3)
                    => (foldl (\cur prev -> prev ++ fromList [ cur, cur ]) "" col)
                    |= col
                )

        mult c1 c2 =
            (fromHex c1) * 16 + fromHex c2
    in
        case col_ of
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
    case Char.toLower c of
        '0' ->
            0

        '1' ->
            1

        '2' ->
            2

        '3' ->
            3

        '4' ->
            4

        '5' ->
            5

        '6' ->
            6

        '7' ->
            7

        '8' ->
            8

        '9' ->
            9

        'a' ->
            10

        'b' ->
            11

        'c' ->
            12

        'd' ->
            13

        'e' ->
            14

        'f' ->
            15

        _ ->
            0


toHex : number -> Char
toHex n =
    case n of
        0 ->
            '0'

        1 ->
            '1'

        2 ->
            '2'

        3 ->
            '3'

        4 ->
            '4'

        5 ->
            '5'

        6 ->
            '6'

        7 ->
            '7'

        8 ->
            '8'

        9 ->
            '9'

        10 ->
            'a'

        11 ->
            'b'

        12 ->
            'c'

        13 ->
            'd'

        14 ->
            'e'

        15 ->
            'f'

        _ ->
            '0'
