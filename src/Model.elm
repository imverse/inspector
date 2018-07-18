module Model exposing (Model)

import InspectorModel.Entity exposing (Entity)


type alias Model =
    { entities : List Entity }
