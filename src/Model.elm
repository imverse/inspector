module Model exposing (..)

import View.WorldViewer.Model
import InspectorModel.Entity exposing (Entity)


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
