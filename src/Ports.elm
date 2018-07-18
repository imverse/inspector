port module Ports exposing (..)

import PortDto.Entity


port replicationToElm : (PortDto.Entity.Root -> msg) -> Sub msg
