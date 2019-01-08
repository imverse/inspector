module View.Component exposing (renderComponentRows)

import Html exposing (..)
import Html.Attributes exposing (..)
import InspectorModel.Component exposing (Component, Field)
import View.Property


renderComponentField : Field -> List (Html msg)
renderComponentField field =
    let
        x =
            tr [ class "component-field" ]
                [ td [ class "label" ] [ text field.name ]
                , td [ class "value" ] [ text field.structure.typeName ]
                ]
    in
    List.concat [ [ x ], View.Property.renderStructureBlock field.structure ]


renderComponentFields : Component -> List (Html msg)
renderComponentFields component =
    List.concatMap renderComponentField component.componentFields


renderComponent : Component -> List (Html msg)
renderComponent component =
    let
        x =
            tr [ class "component" ] [ td [ class "label", colspan 2 ] [ div [] [ text component.name ] ] ]

        y =
            renderComponentFields component
    in
    List.concat [ [ x ], y ]


renderComponents : List Component -> List (Html msg)
renderComponents components =
    List.concatMap renderComponent components


renderComponentRows : List Component -> List (Html msg)
renderComponentRows components =
    renderComponents components
