module Component exposing (..)

import Property


type alias Field =
    { name : String
    , structure : Property.Structure
    }


type alias Component =
    { name : String
    , componentFields : List Field
    }
