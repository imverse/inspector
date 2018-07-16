module Property exposing (..)


type BaseType
    = BaseString String
    | BaseFloat Float
    | BaseInt Int


type alias Type =
    { name : String
    }


propertyBaseTypeToString : BaseType -> String
propertyBaseTypeToString propertyBaseType =
    case propertyBaseType of
        BaseString s ->
            s

        BaseInt i ->
            (toString i)

        BaseFloat f ->
            (toString f)


type alias Field =
    { name : String
    , ptype : BaseType
    }


type alias Structure =
    { fields : List Field
    }


type Value
    = Base BaseType
    | Structured Structure


shortFieldString : Field -> String
shortFieldString field =
    field.name ++ " = " ++ (propertyBaseTypeToString field.ptype)


propertyValueToString : Value -> String
propertyValueToString propertyValue =
    case propertyValue of
        Base b ->
            propertyBaseTypeToString b

        Structured s ->
            String.join ", " (List.map shortFieldString s.fields)


type alias Property =
    { label : String
    , value : Value
    }
