module Routing exposing (..)

import UrlParser exposing (..)
import Navigation exposing (Location)


type Route
    = About
    | Education
    | Work
    | Skills
    | NotFound


routeToString : Route -> String
routeToString r =
    case r of
        About ->
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
                [ UrlParser.map About top
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
