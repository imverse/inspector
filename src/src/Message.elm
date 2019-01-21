module Message exposing (Msg(..))

import Browser
import PortDto.Entity
import Url
import View.WorldViewer.Message


type Msg
    = UpdateStr PortDto.Entity.Root
    | WorldViewerMsg View.WorldViewer.Message.Msg
    | LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
