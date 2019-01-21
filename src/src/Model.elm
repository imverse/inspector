module Model exposing (Model, setEntities, setWorldViewer)

import InspectorModel.Entity exposing (Entity)
import View.WorldViewer.Model


type alias Model =
    { entities : List Entity
    , worldViewer : View.WorldViewer.Model.Model
    }


setEntities : List Entity -> Model -> Model
setEntities newEntities model =
    { model | entities = newEntities }


setWorldViewer : View.WorldViewer.Model.Model -> Model -> Model
setWorldViewer newWorldViewer model =
    { model | worldViewer = newWorldViewer }
