module View.WorldViewer.Model exposing (Model, setPointerIsDown, setSelectedEntityId, setStartPointerDownPosition, setTemporaryViewportOffset, setViewportOffset, setZoomLevel)

import Point


type alias Model =
    { selectedEntityId : Int
    , zoomLevel : Float
    , pointerIsDown : Bool
    , startPointerDownPosition : Point.Point
    , viewportOffset : Point.Point
    , temporaryViewportOffset : Point.Point
    }


setSelectedEntityId : Int -> Model -> Model
setSelectedEntityId newClick model =
    { model | selectedEntityId = newClick }


setZoomLevel : Float -> Model -> Model
setZoomLevel zoomLevel model =
    { model | zoomLevel = zoomLevel }


setPointerIsDown : Bool -> Model -> Model
setPointerIsDown isTouching model =
    { model | pointerIsDown = isTouching }


setStartPointerDownPosition : Point.Point -> Model -> Model
setStartPointerDownPosition position model =
    { model | startPointerDownPosition = position }


setViewportOffset : Point.Point -> Model -> Model
setViewportOffset offset model =
    { model | viewportOffset = offset }


setTemporaryViewportOffset : Point.Point -> Model -> Model
setTemporaryViewportOffset offset model =
    { model | temporaryViewportOffset = offset }
