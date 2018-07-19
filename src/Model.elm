module Model exposing (..)

import InspectorModel.Entity exposing (Entity)
import Point


type alias Model =
    { entities : List Entity
    , selectedEntityId : Int
    , viewerZoomLevel : Float
    , pointerIsTouchingViewer : Bool
    , startTouchPosition : ( Float, Float )
    , viewerOffset : Point.Point
    , temporaryViewerOffset : Point.Point
    }


setEntities : List Entity -> Model -> Model
setEntities newEntities model =
    { model | entities = newEntities }


setSelectedEntityId : Int -> Model -> Model
setSelectedEntityId newClick model =
    { model | selectedEntityId = newClick }


setViewerZoomLevel : Float -> Model -> Model
setViewerZoomLevel zoomLevel model =
    { model | viewerZoomLevel = zoomLevel }


setPointerIsTouchingViewer : Bool -> Model -> Model
setPointerIsTouchingViewer isTouching model =
    { model | pointerIsTouchingViewer = isTouching }


setStartTouchPosition : ( Float, Float ) -> Model -> Model
setStartTouchPosition position model =
    { model | startTouchPosition = position }


setViewerOffset : Point.Point -> Model -> Model
setViewerOffset offset model =
    { model | viewerOffset = offset }


setTemporaryViewerOffset : Point.Point -> Model -> Model
setTemporaryViewerOffset offset model =
    { model | temporaryViewerOffset = offset }
