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
import InspectorModel.Entity as Entity


subscriptions : Model -> Sub Message.Msg
subscriptions model =
    Ports.replicationToElm Message.UpdateStr


filteredEntities : List Entity.Entity -> Int -> List Entity.Entity
filteredEntities entities id =
    case id of
        0 ->
            entities

        _ ->
            List.filter (\entity -> entity.id == id) entities


entityTable : Model -> Html msg
entityTable model =
    let
        entitiesToRender =
            filteredEntities model.entities model.selectedEntityId

        filteredModel =
            Model entitiesToRender model.selectedEntityId
    in
        (View.PropertySheet.render filteredModel)


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
    Model [] 0


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
                    model |> Model.setSelectedEntityId i

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
