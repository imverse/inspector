module EntityDtoToModel exposing (convert)

import InspectorModel.Component as Component
import InspectorModel.Entity as Entity
import InspectorModel.Property as Property
import Json.Decode
import PortDto.Entity


convertJsonObjectToValue : Json.Decode.Value -> Property.Value
convertJsonObjectToValue jsonValue =
    Property.Base (Property.BaseFloat 1.0)


convertProperty : PortDto.Entity.Property -> Property.Property
convertProperty propertyDto =
    Property.Property propertyDto.name (convertJsonObjectToValue propertyDto.value)


intDecoder : Json.Decode.Decoder Property.PrimitiveValue
intDecoder =
    Json.Decode.map Property.BaseInt Json.Decode.int


floatDecoder : Json.Decode.Decoder Property.PrimitiveValue
floatDecoder =
    Json.Decode.map Property.BaseFloat Json.Decode.float


stringDecoder : Json.Decode.Decoder Property.PrimitiveValue
stringDecoder =
    Json.Decode.map Property.BaseString Json.Decode.string


propertyDecoder : Json.Decode.Decoder Property.PrimitiveValue
propertyDecoder =
    Json.Decode.oneOf [ intDecoder, floatDecoder, stringDecoder ]


stringToPrimitiveValue : String -> Json.Decode.Value -> Property.PrimitiveValue
stringToPrimitiveValue typeName value =
    let
        decodedResult =
            Json.Decode.decodeValue propertyDecoder value

        baseValue =
            case decodedResult of
                Ok x ->
                    x

                Err s ->
                    Property.BaseString s
    in
    baseValue


convertStructureField : PortDto.Entity.ComponentField -> PortDto.Entity.Property -> Property.Field
convertStructureField componentFieldDto property =
    Property.Field property.name (stringToPrimitiveValue componentFieldDto.typeName property.value)


convertStructure : PortDto.Entity.ComponentField -> Property.Structure
convertStructure componentFieldDto =
    Property.Structure componentFieldDto.typeName (List.map (\x -> convertStructureField componentFieldDto x) componentFieldDto.properties)


convertComponentField : PortDto.Entity.ComponentField -> Component.Field
convertComponentField componentFieldDto =
    Component.Field componentFieldDto.name (convertStructure componentFieldDto)


convertComponents : PortDto.Entity.Component -> Component.Component
convertComponents componentDto =
    Component.Component componentDto.name (List.map convertComponentField componentDto.fields)


convertEntity : PortDto.Entity.Entity -> Entity.Entity
convertEntity entityDto =
    Entity.Entity entityDto.id entityDto.typeName entityDto.position (List.map convertComponents entityDto.components)


convert : PortDto.Entity.Root -> List Entity.Entity
convert entityDto =
    List.map convertEntity entityDto.entities
