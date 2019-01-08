module InspectorModel.Entity exposing
    ( Entity
    , WorldPosition
    )

{-| This library models entities replicated from a replication server.


# Entity

@docs Entity


# Other types

@docs WorldPosition

-}

import InspectorModel.Component exposing (Component)


{-| The global position of an entity
-}
type alias WorldPosition =
    { x : Float
    , y : Float
    , z : Float
    }


{-| A replicated entity
-}
type alias Entity =
    { id : Int
    , ptype : String
    , position : WorldPosition
    , components : List Component
    }
