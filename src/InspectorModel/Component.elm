module InspectorModel.Component exposing (..)

import InspectorModel.Property as Property


type alias Field =
    { name : String
    , structure : Property.Structure
    }


type alias Component =
    { name : String
    , componentFields : List Field
    }
