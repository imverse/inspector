module Message exposing (..)

import PortDto.Entity


type Msg
    = UpdateStr PortDto.Entity.Root
    | ClickedSvgIcon Int
