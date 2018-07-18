module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import View.PropertySheet
import Ports
import PortDto.Entity
import Model exposing (Model)
import EntityDtoToModel
import Graphics.Graphics as Graphics


subscriptions : Model -> Sub Msg
subscriptions model =
    Ports.replicationToElm UpdateStr


entityTable : Model -> Html msg
entityTable model =
    (View.PropertySheet.renderPropertyTable model)


view : Model -> Html Msg
view model =
    let
        propertySheet =
            div [ class "property-sheet" ] [ (entityTable model) ]

        graphics =
            div [ class "viewer" ] [ Graphics.render model.entities ]
    in
        div [ class "content" ] [ graphics, propertySheet ]


type Msg
    = UpdateStr PortDto.Entity.Root


initModel : Model
initModel =
    Model []


init : ( Model, Cmd Msg )
init =
    ( initModel, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateStr entityDto ->
            ( Model (EntityDtoToModel.convert entityDto), Cmd.none )


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
