module InspectorModel.Entity exposing (..)

import InspectorModel.Component exposing (Component)


type alias WorldPosition =
    { x : Float
    , y : Float
    , z : Float
    }


type alias Entity =
    { id : Int
    , ptype : String
    , position : WorldPosition
    , components : List Component
    }
