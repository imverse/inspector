module Main exposing (entityTable, filteredEntities, init, initModel, main, subscriptions, update, view)

import EntityDtoToModel
import Html exposing (..)
import Html.Attributes exposing (..)
import InspectorModel.Entity as Entity
import Message
import Model exposing (Model)
import Point
import Ports
import View.PropertySheet
import View.WorldViewer.Model
import View.WorldViewer.Update
import View.WorldViewer.View


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
            filteredEntities model.entities model.worldViewer.selectedEntityId

        filteredModel =
            Model entitiesToRender model.worldViewer
    in
    View.PropertySheet.render filteredModel


view : Model -> Html Message.Msg
view model =
    let
        propertySheet =
            div [ class "property-sheet-column" ] [ entityTable model ]

        viewerOffset =
            Point.add model.worldViewer.viewportOffset model.worldViewer.temporaryViewportOffset

        graphics =
            div [ class "viewer-column" ] [ View.WorldViewer.View.render model.worldViewer model.entities ]
    in
    div [ class "root" ] [ div [ class "content" ] [ Html.map Message.WorldViewerMsg graphics, propertySheet ] ]


initModel : Model
initModel =
    Model [] (View.WorldViewer.Model.Model 0 2.0 False ( 0, 0 ) ( 0, 0 ) ( 0, 0 ))


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

        Message.WorldViewerMsg worldViewerMsg ->
            let
                ( updatedModel, newMsg ) =
                    View.WorldViewer.Update.update worldViewerMsg model.worldViewer

                newModel =
                    model
                        |> Model.setWorldViewer updatedModel
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
