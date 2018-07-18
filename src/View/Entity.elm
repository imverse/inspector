module View.Entity exposing (renderEntityRows)

import View.Component
import InspectorModel.Entity exposing (Entity)
import Html exposing (..)
import Html.Attributes exposing (..)


renderEntity : Entity -> List (Html msg)
renderEntity entity =
    let
        x =
            tr [ class "entity" ] [ td [ (class "label"), (colspan 2) ] [ div [] [ text ("#" ++ (toString entity.id)), text entity.ptype ] ] ]

        y =
            View.Component.renderComponentRows entity.components
    in
        List.concat [ [ x ], y ]


renderEntities : List Entity -> List (Html msg)
renderEntities entities =
    List.concatMap renderEntity entities


renderEntityRows : List Entity -> List (Html msg)
renderEntityRows entities =
    (renderEntities entities)
