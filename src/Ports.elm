port module Ports exposing (..)


port replicationToElm : (String -> msg) -> Sub msg
