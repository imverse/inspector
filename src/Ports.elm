port module Ports exposing (replicationToElm)

import PortDto.Entity


port replicationToElm : (PortDto.Entity.Root -> msg) -> Sub msg
