module View.WorldViewer.View exposing (render)

{-| This library renders entities using svg.


# Render

@docs render

-}

import Browser.Events exposing (..)
import Html exposing (..)
import Html.Attributes
import Html.Events
import InspectorModel.Entity exposing (Entity)
import Json.Decode as Decode exposing (Decoder)
import Point
import Svg exposing (..)
import Svg.Attributes exposing (..)
import View.WorldViewer.Message as Message
import View.WorldViewer.Model exposing (Model)


type alias IconName =
    String


entityIcon : Int -> String -> Point.Point -> Html.Html Message.Msg
entityIcon id iconName position =
    let
        translateString =
            "left: " ++ (String.fromFloat <| Point.xCoordinate position) ++ ", top:" ++ (String.fromFloat <| Point.yCoordinate position) ++ ")"

        scaleString =
            "scale(0.05)"

        transformString =
            String.join "," [ scaleString, translateString ]

        xString =
            String.fromFloat (Point.xCoordinate position) ++ "px"

        yString =
            String.fromFloat (Point.yCoordinate position) ++ "px"

        attributes =
            [ class "icon"
            , Html.Attributes.style "left" xString
            , Html.Attributes.style "top" yString
            ]

        iconReference =
            Svg.use [ xlinkHref ("#" ++ iconName), Svg.Attributes.transform "scale(0.05)" ] []

        clickOptions =
            { stopPropagation = True
            , preventDefault = True
            }

        {-
           clickEvent =
               Html.Events.custom "click" clickOptions (Json.Decode.succeed (Message.ClickedSvgIcon id))
        -}
        svgIcon =
            Svg.svg [ class "icon-content", Svg.Attributes.viewBox "0 0 32 32" ] [ iconReference ]
    in
    div attributes [ svgIcon ]


iconNameFromType : String -> IconName
iconNameFromType ptype =
    case ptype of
        "AttackMech" ->
            "robot"

        "SpaceGlider" ->
            "spaceship"

        "Ground" ->
            "terrain"

        _ ->
            "generic"


type alias Pos =
    { x : Float, y : Float }


decodeClientPosition : Decoder Point.Point
decodeClientPosition =
    let
        x =
            Decode.field "clientX" Decode.float

        y =
            Decode.field "clientY" Decode.float

        position =
            Decode.map2 Point.Point x y
    in
    position


mouseMoveDecoder : Decoder Message.Msg
mouseMoveDecoder =
    Decode.map Message.PointerDraggingViewer decodeClientPosition


backgroundSurface : Float -> List (Html.Html Message.Msg) -> Html.Html Message.Msg
backgroundSurface zoom children =
    let
        mouseDown =
            onMouseDown mouseMoveDecoder

        mouseUp =
            onMouseUp mouseMoveDecoder

        mouseMove =
            onMouseMove mouseMoveDecoder

        {- wheelEvent =
           Wheel.onWheel (\event -> Message.ZoomViewer <| zoom - event.deltaY * 0.01)
        -}
    in
    div [ class "icons", Html.Events.onClick (Message.ClickedSvgIcon 0) ] children


{-| Render entities both as svg icons and a property sheet.
-}
render : Model -> List Entity -> Html.Html Message.Msg
render model entities =
    let
        allIcons =
            List.map
                (\entity ->
                    let
                        x =
                            entity.position.x * model.zoomLevel + 32

                        y =
                            entity.position.z * model.zoomLevel + 32

                        entityPos =
                            { x = x, y = y }

                        totalOffset =
                            Point.add model.viewportOffset model.temporaryViewportOffset

                        adjustedPos =
                            Point.sub entityPos totalOffset

                        iconName =
                            iconNameFromType entity.ptype
                    in
                    entityIcon entity.id iconName adjustedPos
                )
                entities
    in
    Html.node "imverse-world-viewer" [] [ backgroundSurface model.zoomLevel allIcons ]
