module Model exposing (Model, setEntities, setDebugClickedSvgIcon)

import InspectorModel.Entity exposing (Entity)


type alias Model =
    { entities : List Entity
    , debugClickedMe : Bool
    }


setEntities : List Entity -> Model -> Model
setEntities newEntities model =
    { model | entities = newEntities }


setDebugClickedSvgIcon : Bool -> Model -> Model
setDebugClickedSvgIcon newClick model =
    { model | debugClickedMe = newClick }
