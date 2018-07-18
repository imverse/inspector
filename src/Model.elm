module Model exposing (Model, setEntities, setSelectedEntityId)

import InspectorModel.Entity exposing (Entity)


type alias Model =
    { entities : List Entity
    , selectedEntityId : Int
    }


setEntities : List Entity -> Model -> Model
setEntities newEntities model =
    { model | entities = newEntities }


setSelectedEntityId : Int -> Model -> Model
setSelectedEntityId newClick model =
    { model | selectedEntityId = newClick }
