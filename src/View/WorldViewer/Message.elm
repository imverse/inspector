module View.WorldViewer.Message exposing (..)


type Msg
    = ClickedSvgIcon Int
    | ZoomViewer Float
    | PointerStartTouchingViewer ( Float, Float )
    | PointerStoppedTouchingViewer ( Float, Float )
    | PointerDraggingViewer ( Float, Float )
