module Main exposing (entityTable, filteredEntities, init, initModel, main, subscriptions, update, view)

import Browser exposing (..)
import Browser.Navigation as Nav
import EntityDtoToModel
import Html exposing (..)
import Html.Attributes exposing (..)
import InspectorModel.Entity as Entity
import Message
import Model exposing (Model)
import Point
import Ports
import Url
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


viewDocument : Model -> Document Message.Msg
viewDocument model =
    let
        html =
            view model
    in
    Document "hello" [ html ]


initModel : Model
initModel =
    Model [] (View.WorldViewer.Model.Model 0 2.0 False { x = 0, y = 0 } { x = 0, y = 0 } { x = 0, y = 0 })


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Message.Msg )
init flags url key =
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

        Message.LinkClicked x ->
            ( model, Cmd.none )

        Message.UrlChanged x ->
            ( model, Cmd.none )


main : Program () Model Message.Msg
main =
    Browser.application
        { init = init
        , view = viewDocument
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = Message.UrlChanged
        , onUrlRequest = Message.LinkClicked
        }
