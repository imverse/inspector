module InspectorModel.Property exposing (Field, PrimitiveValue(..), Property, Structure, Type, Value(..), primitiveToString, shortFieldString, valueToString)


type PrimitiveValue
    = BaseString String
    | BaseFloat Float
    | BaseInt Int


type alias Type =
    { name : String
    }


primitiveToString : PrimitiveValue -> String
primitiveToString propertyPrimitiveValue =
    case propertyPrimitiveValue of
        BaseString s ->
            s

        BaseInt i ->
            toString i

        BaseFloat f ->
            toString f


type alias Field =
    { name : String
    , ptype : PrimitiveValue
    }


type alias Structure =
    { typeName : String
    , fields : List Field
    }


type Value
    = Base PrimitiveValue
    | Structured Structure


shortFieldString : Field -> String
shortFieldString field =
    field.name ++ " = " ++ primitiveToString field.ptype


valueToString : Value -> String
valueToString propertyValue =
    case propertyValue of
        Base b ->
            primitiveToString b

        Structured s ->
            String.join ", " (List.map shortFieldString s.fields)


type alias Property =
    { label : String
    , value : Value
    }
