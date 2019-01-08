module PortDto.Entity exposing (Root, Entity, Position, Component, ComponentField, Property)

{-| This library models Data Transfer Objects. Objects that are sent from the javascript world (replication-js).


# Entity

@docs Root, Entity, Position, Component, ComponentField, Property

-}

import Json.Decode


{-| Property is a name and value (Int, String or Float)
-}
type alias Property =
    { name : String
    , value : Json.Decode.Value
    }


{-| ComponentField containing the name and list of properties
-}
type alias ComponentField =
    { name : String
    , properties : List Property
    , typeName : String
    }


{-| Component with the list of structures (ComponentField)s
-}
type alias Component =
    { typeName : String
    , name : String
    , fields : List ComponentField
    }


{-| World Position
-}
type alias Position =
    { x : Float
    , y : Float
    , z : Float
    }


{-| An entity with a list of Components
-}
type alias Entity =
    { id : Int
    , typeName : String
    , components : List Component
    , position : Position
    }


{-| The root of the javascript object that is sent from replication
-}
type alias Root =
    { entities : List Entity
    }
