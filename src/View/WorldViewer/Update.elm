module View.WorldViewer.Update exposing (update)

import Point
import View.WorldViewer.Message as Message
import View.WorldViewer.Model as Model


update : Message.Msg -> Model.Model -> ( Model.Model, Cmd Message.Msg )
update msg model =
    case msg of
        Message.ClickedSvgIcon i ->
            let
                newModel =
                    model |> Model.setSelectedEntityId i
            in
            ( newModel, Cmd.none )

        Message.ZoomViewer zoomLevel ->
            ( model |> Model.setZoomLevel zoomLevel, Cmd.none )

        Message.PointerStartTouchingViewer position ->
            ( model
                |> Model.setPointerIsDown True
                |> Model.setStartPointerDownPosition position
            , Cmd.none
            )

        Message.PointerStoppedTouchingViewer position ->
            let
                diff =
                    Point.sub model.startPointerDownPosition position

                newOffset =
                    Point.add model.viewportOffset model.temporaryViewportOffset
            in
            ( model
                |> Model.setPointerIsDown False
                |> Model.setViewportOffset newOffset
                |> Model.setTemporaryViewportOffset ( 0, 0 )
            , Cmd.none
            )

        Message.PointerDraggingViewer position ->
            let
                diff =
                    Point.sub model.startPointerDownPosition position
            in
            if model.pointerIsDown then
                ( model
                    |> Model.setTemporaryViewportOffset diff
                , Cmd.none
                )

            else
                ( model, Cmd.none )
