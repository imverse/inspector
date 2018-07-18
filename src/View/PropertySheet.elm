module View.PropertySheet exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Model exposing (Model)
import View.Entity
import InspectorModel.Entity exposing (Entity)


renderEntities : List Entity -> List (Html msg)
renderEntities entities =
    (View.Entity.renderEntityRows entities)


renderPropertyTable : Model -> Html msg
renderPropertyTable model =
    table [ class "property-sheet" ]
        [ thead []
            [ td [] [ text "Name" ]
            , td [] [ text "Value" ]
            ]
        , tbody []
            (renderEntities model.entities)
        ]
