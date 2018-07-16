module Hello exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)


type PropertyBaseType
    = BaseString String
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


propertyValueToString : PropertyValue -> String
propertyValueToString propertyValue =
    case propertyValue of
        Base b ->
            propertyBaseTypeToString b

        Structured s ->
            "not yet"


type alias Property =
    { label : String
    , value : PropertyValue
    }


testProperties : List Property
testProperties =
    [ Property "My Own Proper tjmmm" (Base (BaseInt 42))
    , Property "Another Proper" (Base (BaseString "My Name"))
    ]


renderPropertyValue : PropertyValue -> Html msg
renderPropertyValue propertyValue =
    case propertyValue of
        Base b ->
            text (propertyValueToString propertyValue)

        Structured s ->
            text "Not yet"


renderProperty : Property -> Html msg
renderProperty property =
    tr [ class "property" ]
        [ td [ class "label" ] [ text property.label ]
        , td [ class "value" ] [ renderPropertyValue property.value ]
        ]


renderProperties : List Property -> List (Html msg)
renderProperties properties =
    List.map renderProperty properties


renderPropertyTable : List Property -> Html msg
renderPropertyTable properties =
    table [ class "propertySheet" ]
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
