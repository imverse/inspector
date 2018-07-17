module EntityDto exposing (..)

import Json.Decode


type alias Property =
    { name : String
    , value : Json.Decode.Value
    }


type alias ComponentField =
    { name : String
    , properties : List Property
    , typeName : String
    }


type alias Component =
    { typeName : String
    , name : String
    , fields : List ComponentField
    }


type alias Entity =
    { id : Int
    , typeName : String
    , components : List Component
    }


type alias Root =
    { entities : List Entity
    }
