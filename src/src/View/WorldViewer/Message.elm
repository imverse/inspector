module View.WorldViewer.Message exposing (Msg(..))

import Point


type Msg
    = ClickedSvgIcon Int
    | ZoomViewer Float
    | PointerStartTouchingViewer Point.Point
    | PointerStoppedTouchingViewer Point.Point
    | PointerDraggingViewer Point.Point
