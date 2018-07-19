module Message exposing (..)

import PortDto.Entity


type Msg
    = UpdateStr PortDto.Entity.Root
    | ClickedSvgIcon Int
    | ZoomViewer Float
    | PointerStartTouchingViewer ( Float, Float )
    | PointerStoppedTouchingViewer ( Float, Float )
    | PointerDraggingViewer ( Float, Float )
    | Nope
