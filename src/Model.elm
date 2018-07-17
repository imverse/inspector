module Model exposing (Model)

import Entity


type alias Model =
    { entities : List Entity.Entity }
