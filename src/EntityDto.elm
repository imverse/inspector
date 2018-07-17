module EntityDto exposing (..)

import Json.Decode


type alias StructureField =
    { name : String
    , value : Json.Decode.Value
    }


type alias Structure =
    { typeName : String
    , fields : List StructureField
    }


type alias ComponentField =
    { name : String
    , structure : Structure
    }


type alias Component =
    { typeName : String
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
