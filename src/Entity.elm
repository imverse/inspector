module Entity exposing (..)

import Component


type alias Entity =
    { id : Int
    , ptype : String
    , components : List Component.Component
    }
