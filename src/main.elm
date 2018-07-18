module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import View.PropertySheet
import Ports
import Model exposing (Model)
import EntityDtoToModel
import Graphics.Graphics as Graphics
import Message
import Debug


subscriptions : Model -> Sub Message.Msg
subscriptions model =
    Ports.replicationToElm Message.UpdateStr


entityTable : Model -> Html msg
entityTable model =
    (View.PropertySheet.render model)


view : Model -> Html Message.Msg
view model =
    let
        propertySheet =
            div [ class "property-sheet" ] [ (entityTable model) ]

        graphics =
            div [ class "viewer" ] [ Graphics.render model.entities ]
    in
        div [ class "content" ] [ graphics, propertySheet ]


initModel : Model
initModel =
    Model [] False


init : ( Model, Cmd Message.Msg )
init =
    ( initModel, Cmd.none )


update : Message.Msg -> Model -> ( Model, Cmd Message.Msg )
update msg model =
    case msg of
        Message.UpdateStr entityDto ->
            let
                newModel =
                    model
                        |> Model.setEntities (EntityDtoToModel.convert entityDto)
            in
                ( newModel, Cmd.none )

        Message.ClickedSvgIcon i ->
            let
                newModel =
                    model |> Model.setDebugClickedSvgIcon True

                fake =
                    Debug.log "Clicked" i
            in
                ( newModel, Cmd.none )


main : Program Never Model Message.Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
