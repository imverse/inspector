module Hello exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Property
import PropertyUi


testProperties : List Property.Property
testProperties =
    [ Property.Property "Example Name" (Property.Base (Property.BaseInt 42))
    , Property.Property "Structured Name"
        (Property.Structured
            (Property.Structure
                [ Property.Field "x" (Property.BaseFloat 2.3)
                , Property.Field "y" (Property.BaseFloat 2.5)
                ]
            )
        )
    , Property.Property "Another Name" (Property.Base (Property.BaseString "My Name"))
    ]


hackInsertCssLink : Html msg -> List (Html msg)
hackInsertCssLink children =
    [ node "link" [ rel "stylesheet", href "style.css" ] []
    , children
    ]


main : Html msg
main =
    div [] (hackInsertCssLink (PropertyUi.renderPropertyTable testProperties))
