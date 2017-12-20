module Routing exposing (..)

import UrlParser exposing (..)
import Navigation exposing (Location)


type Route
    = Home
    | Education
    | Work
    | Skills
    | NotFound


routeToString r =
    case r of
        Home ->
            "/#/"

        Education ->
            "/#/education"

        Work ->
            "/#/work"

        Skills ->
            "/#/skills"

        _ ->
            "/#/nowhere"


parseLocation : Location -> Route
parseLocation location =
    let
        matchers =
            oneOf
                [ UrlParser.map Home top
                , UrlParser.map Education (UrlParser.s "education")
                , UrlParser.map Work (UrlParser.s "work")
                , UrlParser.map Skills (UrlParser.s "skills")
                ]
    in
        case (parseHash matchers location) of
            Just route ->
                route

            Nothing ->
                NotFound
