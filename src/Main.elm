module Main exposing (..)

import Model exposing (..)
import Theming exposing (..)
import Title exposing (title)
import Fonts exposing (..)
import Content exposing (content)
import Routing exposing (..)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes as Attr exposing (css, type_, src, href)
import Css exposing (fontFamilies, backgroundColor, hex, width, height, pct)
import String exposing (..)
import Navigation exposing (Location)
import UrlParser exposing (..)
import AnimationFrame exposing (..)
import Time exposing (Time, second)
import Mouse exposing (..)
import Animation exposing (..)


mainStyle =
    [ fontFamilies [ fonts.body ]
    , backgroundColor colors.bg
    , width <| pct 100
    , height <| pct 100
    ]



---- UPDATE ----


type Msg
    = OnLocationChange Location
    | Tick Time
    | MouseClick Position


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnLocationChange location ->
            ( { model | route = parseLocation <| location }, Cmd.none )

        Tick dt ->
            ( { model
                | clock = model.clock + dt
                , interp = animate model.clock model.currentAnimation
                , currentAnimation =
                    if model.interp == 0 then
                        openAnim model.clock
                    else
                        model.currentAnimation
                , route =
                    if model.interp == 0 then
                        (case model.route of
                            Home ->
                                Work

                            Work ->
                                Education

                            Education ->
                                Skills

                            Skills ->
                                NotFound

                            NotFound ->
                                Home
                        )
                    else
                        model.route
              }
            , Cmd.none
            )

        MouseClick _ ->
            ( { model
                | currentAnimation =
                    if model.interp == 1 then
                        closeAnim model.clock
                    else
                        model.currentAnimation
              }
            , Cmd.none
            )


modulo : Float -> Float -> Float
modulo a b =
    if a >= b then
        modulo (a - b) b
    else
        a



---- VIEW ----


view : Model -> Html Msg
view model =
    div
        [ css mainStyle ]
    <|
        List.concat
            [ [ importNode ]
            , Title.title model.route model.interp
            , [ Content.content ipsum model.interp ]
            ]



---- PROGRAM ----


closeAnim time =
    animation time |> from 1 |> to 0 |> duration (1 * second)


openAnim time =
    animation time |> from 0 |> to 1 |> duration (1 * second)


subs : Sub Msg
subs =
    Sub.batch
        [ AnimationFrame.diffs Tick
        , Mouse.clicks MouseClick
        ]


main : Program Never Model Msg
main =
    Navigation.program OnLocationChange
        { view = view >> toUnstyled
        , init = init
        , update = update
        , subscriptions = always subs
        }


ipsum : String
ipsum =
    String.concat
        [ "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut a lorem"
        , "nulla. Proin vel sagittis neque, ut interdum velit. Fusce "
        , "fermentum maximus condimentum. Vestibulum quis dignissim mauris. "
        , "Proin sodales erat sit amet nisi vulputate aliquam. Etiam maximus "
        , "dictum nibh tristique semper. Cras semper eu arcu sit amet "
        , "convallis. Morbi dapibus et sem sed dignissim.\n\nPhasellus sem "
        , "tortor, scelerisque et placerat eget, efficitur id lacus. Quisque "
        , "sapien purus, ultricies in urna at, interdum dapibus nisl. Quisque "
        , "id dui in arcu accumsan lacinia vel quis eros. Fusce orci ipsum, "
        , "aliquet ut tempus non, pharetra tempus nulla. Nullam at magna "
        , "purus. Ut lacinia iaculis neque. Integer sed leo maximus, venenatis"
        , " tortor sit amet, volutpat risus. Fusce nec leo in sem porta "
        , "aliquet. Vivamus laoreet varius ipsum, tempor vehicula nisl "
        , "pellentesque sed. Mauris luctus orci eget nisl hendrerit aliquet. "
        , "In quis semper arcu, in viverra ante. Sed aliquet volutpat diam ut "
        , "facilisis. Quisque eget lorem tortor. Donec sed finibus velit.\n\n"
        , "Fusce ac mauris sed risus convallis rutrum. Nullam cursus, ipsum ac"
        , " finibus ultricies, felis nulla bibendum ipsum, et pretium erat "
        , "orci vel tellus. Donec volutpat justo id erat pretium luctus. Sed "
        , "et faucibus diam. Suspendisse elit leo, elementum ut hendrerit sed,"
        , " consectetur et nisl. Aenean a pharetra enim. Phasellus tempus a "
        , "nisl a facilisis. Aliquam consequat rhoncus tristique.\n\nUt lacus "
        , "ex, feugiat mattis turpis sit amet, tempor aliquet eros. Interdum "
        , "et malesuada fames ac ante ipsum primis in faucibus. Sed molestie "
        , "arcu eget nisi fringilla aliquam. Ut venenatis pharetra massa, et "
        , "hendrerit turpis bibendum ut. Proin vehicula odio sit amet neque "
        , "ultricies, pulvinar semper metus rhoncus. Phasellus in commodo "
        , "urna. Pellentesque habitant morbi tristique senectus et netus et "
        , "malesuada fames ac turpis egestas. Praesent laoreet est eu "
        , "dignissim efficitur. Duis non mi dui. Etiam luctus egestas lacus a "
        , "interdum. Vestibulum lorem augue, fermentum ut dignissim vitae, "
        , "pellentesque non lectus. Duis eget pharetra ligula.\n\nSed vel "
        , "turpis vel erat vestibulum ultrices. Aenean laoreet, lorem et "
        , "gravida vulputate, elit mi ornare velit, a malesuada quam diam vel"
        , " massa. Interdum et malesuada fames ac ante ipsum primis in "
        , "faucibus. Duis viverra ex a nisi porttitor imperdiet. Nullam "
        , "pharetra facilisis sagittis. Nullam augue tortor, condimentum nec "
        , "nisl a, pharetra iaculis dui. In id sem nunc. Donec convallis, "
        , "magna at lobortis ornare, arcu massa volutpat lorem, in lobortis "
        , "quam erat et mi. Integer mi ligula, volutpat quis volutpat sit "
        , "amet, placerat ut mauris. Maecenas at feugiat nulla, vitae finibus "
        , "metus. Integer a ligula non lorem dictum pretium. In facilisis "
        , "nisi arcu, fermentum fermentum est blandit pulvinar. Etiam sit "
        , "amet risus enim. Morbi ullamcorper tempor elit et aliquet. Mauris "
        , "egestas lectus consequat, suscipit purus sed, tincidunt turpis. "
        , "Phasellus semper mattis urna ut vestibulum. "
        ]
