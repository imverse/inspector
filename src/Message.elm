module Message exposing (Msg(..))

import PortDto.Entity
import View.WorldViewer.Message


type Msg
    = UpdateStr PortDto.Entity.Root
    | WorldViewerMsg View.WorldViewer.Message.Msg
