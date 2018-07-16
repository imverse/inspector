module Hello exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)


type PropertyBaseType
    = BaseString String
    | BaseFloat Float
    | BaseInt Int


type alias PropertyType =
    { name : String
    }


propertyBaseTypeToString : PropertyBaseType -> String
propertyBaseTypeToString propertyBaseType =
    case propertyBaseType of
        BaseString s ->
            s

        BaseInt i ->
            (toString i)

        BaseFloat f ->
            (toString f)


type alias PropertyField =
    { name : String
    , ptype : PropertyBaseType
    }


type alias PropertyStructure =
    { fields : List PropertyField
    }


type PropertyValue
    = Base PropertyBaseType
    | Structured PropertyStructure


shortFieldString : PropertyField -> String
shortFieldString field =
    field.name ++ " = " ++ (propertyBaseTypeToString field.ptype)


propertyValueToString : PropertyValue -> String
propertyValueToString propertyValue =
    case propertyValue of
        Base b ->
            propertyBaseTypeToString b

        Structured s ->
            String.join ", " (List.map shortFieldString s.fields)


type alias Property =
    { label : String
    , value : PropertyValue
    }


testProperties : List Property
testProperties =
    [ Property "Example Name" (Base (BaseInt 42))
    , Property "Structured Name"
        (Structured
            (PropertyStructure
                [ PropertyField "x" (BaseFloat 2.3)
                , PropertyField "y" (BaseFloat 2.5)
                ]
            )
        )
    , Property "Another Name" (Base (BaseString "My Name"))
    ]


renderPropertyValue : PropertyValue -> Html msg
renderPropertyValue propertyValue =
    case propertyValue of
        Base b ->
            text (propertyValueToString propertyValue)

        Structured s ->
            text (propertyValueToString propertyValue)


renderPropertyLine : Property -> Html msg
renderPropertyLine property =
    tr [ class "property" ]
        [ td [ class "label" ] [ text property.label ]
        , td [ class "value" ] [ renderPropertyValue property.value ]
        ]


renderStructureBlock : PropertyStructure -> List (Html msg)
renderStructureBlock s =
    List.map renderStructuredField s.fields


propertyIsStructured : Property -> Bool
propertyIsStructured property =
    case property.value of
        Base b ->
            False

        Structured s ->
            True


renderProperty : Property -> List (Html msg)
renderProperty property =
    let
        base =
            renderPropertyLine property
    in
        case property.value of
            Structured s ->
                (List.concat [ [ base ], (renderStructureBlock s) ])

            Base b ->
                [ base ]


renderStructuredField : PropertyField -> Html msg
renderStructuredField field =
    tr [ class "structure-field" ] [ td [ class "label" ] [ text field.name ], td [ class "value" ] [ text (propertyBaseTypeToString field.ptype) ] ]


renderProperties : List Property -> List (Html msg)
renderProperties properties =
    List.concatMap renderProperty properties


renderPropertyTable : List Property -> Html msg
renderPropertyTable properties =
    table [ class "property-sheet" ]
        [ thead []
            [ td [] [ text "Name" ]
            , td [] [ text "Value" ]
            ]
        , tbody []
            (renderProperties properties)
        ]


hackInsertCssLink : Html msg -> List (Html msg)
hackInsertCssLink children =
    [ node "link" [ rel "stylesheet", href "style.css" ] []
    , children
    ]


main : Html msg
main =
    div [] (hackInsertCssLink (renderPropertyTable testProperties))
