module Routing exposing (..)

import Maybe exposing (withDefault)
import Navigation exposing (Location)
import UrlParser exposing (..)


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

        NotFound ->
            "/#/nowhere"


routeToValue : Route -> a -> a -> a -> a -> a -> a
routeToValue r vAbout vEducation vWork vSkills vNotFound =
    case r of
        About ->
            vAbout

        Education ->
            vEducation

        Work ->
            vWork

        Skills ->
            vSkills

        NotFound ->
            vNotFound


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
        parseHash matchers location |> withDefault NotFound
