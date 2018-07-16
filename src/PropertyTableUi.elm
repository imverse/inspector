module PropertyTableUi exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)


renderPropertyTable : List (Html msg) -> Html msg
renderPropertyTable x =
    table [ class "property-sheet" ]
        [ thead []
            [ td [] [ text "Name" ]
            , td [] [ text "Value" ]
            ]
        , tbody []
            x
        ]
