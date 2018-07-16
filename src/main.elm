module Hello exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Entity
import Property
import EntityUi
import PropertyUi
import Component
import PropertyTableUi


testProperties : List Property.Property
testProperties =
    [ Property.Property "Example Name" (Property.Base (Property.BaseInt 42))
    , Property.Property "Structured Name"
        (Property.Structured
            (Property.Structure "Vector2D"
                [ Property.Field "x" (Property.BaseFloat 2.3)
                , Property.Field "y" (Property.BaseFloat 2.5)
                ]
            )
        )
    , Property.Property "Another Name" (Property.Base (Property.BaseString "My Name"))
    ]


testStructure : Property.Structure
testStructure =
    (Property.Structure "Vector3f"
        [ Property.Field "x" (Property.BaseFloat 1.5)
        , Property.Field "y" (Property.BaseFloat 2.6)
        , Property.Field "z" (Property.BaseFloat 3.7)
        ]
    )


tileStructure : Property.Structure
tileStructure =
    (Property.Structure "Gfx"
        [ Property.Field "tileIndex" (Property.BaseFloat 99)
        ]
    )


testComponents : List Component.Component
testComponents =
    [ (Component.Component "body" [ (Component.Field "position" testStructure), (Component.Field "rotation" testStructure) ])
    , (Component.Component "gfx" [ (Component.Field "tileData" tileStructure) ])
    ]


testEntities : List Entity.Entity
testEntities =
    [ (Entity.Entity 2 "FirstEntity" testComponents)
    , (Entity.Entity 3 "AnotherEntity" testComponents)
    ]


hackInsertCssLink : Html msg -> List (Html msg)
hackInsertCssLink children =
    [ node "link" [ rel "stylesheet", href "style.css" ] []
    , children
    ]


entityTable : Html msg
entityTable =
    let
        entityElements =
            (EntityUi.renderEntityRows testEntities)

        propertyElements =
            (PropertyUi.renderProperties testProperties)
    in
        (PropertyTableUi.renderPropertyTable entityElements)


main : Html msg
main =
    div [] (hackInsertCssLink entityTable)
