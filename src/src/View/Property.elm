module View.Property exposing (renderProperties, renderStructureBlock)

import Html exposing (..)
import Html.Attributes exposing (..)
import InspectorModel.Property as Property


renderPropertyValue : Property.Value -> Html msg
renderPropertyValue propertyValue =
    case propertyValue of
        Property.Base b ->
            text (Property.valueToString propertyValue)

        Property.Structured s ->
            text (Property.valueToString propertyValue)


renderPropertyLine : Property.Property -> Html msg
renderPropertyLine property =
    tr [ class "property" ]
        [ td [ class "label" ] [ text property.label ]
        , td [ class "value" ] [ renderPropertyValue property.value ]
        ]


renderStructureBlock : Property.Structure -> List (Html msg)
renderStructureBlock s =
    List.map renderStructuredField s.fields


propertyIsStructured : Property.Property -> Bool
propertyIsStructured property =
    case property.value of
        Property.Base b ->
            False

        Property.Structured s ->
            True


renderProperty : Property.Property -> List (Html msg)
renderProperty property =
    let
        base =
            renderPropertyLine property
    in
    case property.value of
        Property.Structured s ->
            List.concat [ [ base ], renderStructureBlock s ]

        Property.Base b ->
            [ base ]


renderStructuredField : Property.Field -> Html msg
renderStructuredField field =
    tr [ class "structure-field" ] [ td [ class "label" ] [ text field.name ], td [ class "value" ] [ text (Property.primitiveToString field.ptype) ] ]


renderProperties : List Property.Property -> List (Html msg)
renderProperties properties =
    List.concatMap renderProperty properties
