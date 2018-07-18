module EntityDtoToModel exposing (convert)

import EntityDto
import Entity
import Component
import Property
import Json.Decode


convertJsonObjectToValue : Json.Decode.Value -> Property.Value
convertJsonObjectToValue jsonValue =
    Property.Base (Property.BaseFloat 1.0)


convertProperty : EntityDto.Property -> Property.Property
convertProperty propertyDto =
    Property.Property propertyDto.name (convertJsonObjectToValue propertyDto.value)


intDecoder : Json.Decode.Decoder Property.BaseType
intDecoder =
    Json.Decode.map Property.BaseInt Json.Decode.int


floatDecoder : Json.Decode.Decoder Property.BaseType
floatDecoder =
    Json.Decode.map Property.BaseFloat Json.Decode.float


stringDecoder : Json.Decode.Decoder Property.BaseType
stringDecoder =
    Json.Decode.map Property.BaseString Json.Decode.string


propertyDecoder : Json.Decode.Decoder Property.BaseType
propertyDecoder =
    Json.Decode.oneOf [ intDecoder, floatDecoder, stringDecoder ]


stringToBaseType : String -> Json.Decode.Value -> Property.BaseType
stringToBaseType typeName value =
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


convertStructureField : EntityDto.ComponentField -> EntityDto.Property -> Property.Field
convertStructureField componentFieldDto property =
    Property.Field property.name (stringToBaseType componentFieldDto.typeName property.value)


convertStructure : EntityDto.ComponentField -> Property.Structure
convertStructure componentFieldDto =
    Property.Structure componentFieldDto.typeName (List.map (\x -> (convertStructureField componentFieldDto x)) componentFieldDto.properties)


convertComponentField : EntityDto.ComponentField -> Component.Field
convertComponentField componentFieldDto =
    Component.Field componentFieldDto.name (convertStructure componentFieldDto)


convertComponents : EntityDto.Component -> Component.Component
convertComponents componentDto =
    Component.Component componentDto.name (List.map convertComponentField componentDto.fields)


convertEntity : EntityDto.Entity -> Entity.Entity
convertEntity entityDto =
    Entity.Entity entityDto.id entityDto.typeName entityDto.position (List.map convertComponents entityDto.components)


convert : EntityDto.Root -> List Entity.Entity
convert entityDto =
    List.map convertEntity entityDto.entities
