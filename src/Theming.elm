module Theming exposing (..)

import Css exposing (..)


colors : { accent : Color, bg : Color, fg : Color, primary : Color }
colors =
    { primary = hex colorsStr.primary
    , bg = hex colorsStr.bg
    , fg = hex colorsStr.fg
    , accent = hex colorsStr.accent
    }


colorsStr : { bg : String, fg : String, primary : String, accent : String }
colorsStr =
    { primary = "#ff0", bg = "#000", fg = "#fff", accent = "#f00" }
