module EntityUi exposing (renderEntityRows)

import ComponentUi
import Entity
import Html exposing (..)
import Html.Attributes exposing (..)


renderEntity : Entity.Entity -> List (Html msg)
renderEntity entity =
    let
        x =
            tr [ class "entity" ] [ td [ (class "label"), (colspan 2) ] [ div [] [ text ("#" ++ (toString entity.id)), text entity.ptype ] ] ]

        y =
            ComponentUi.renderComponentRows entity.components
    in
        List.concat [ [ x ], y ]


renderEntities : List Entity.Entity -> List (Html msg)
renderEntities entities =
    List.concatMap renderEntity entities


renderEntityRows : List Entity.Entity -> List (Html msg)
renderEntityRows entities =
    (renderEntities entities)
