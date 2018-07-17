port module Ports exposing (..)

import EntityDto


port replicationToElm : (EntityDto.Root -> msg) -> Sub msg
