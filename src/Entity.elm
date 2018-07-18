module Entity exposing (..)

import Component


type alias WorldPosition =
    { x : Float
    , y : Float
    , z : Float
    }


type alias Entity =
    { id : Int
    , ptype : String
    , position : WorldPosition
    , components : List Component.Component
    }
