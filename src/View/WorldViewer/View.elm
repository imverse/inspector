module View.WorldViewer.View exposing (render)

{-| This library renders entities using svg.


# Render

@docs render

-}

import Svg exposing (..)
import Svg.Attributes exposing (..)
import Html exposing (..)
import Html.Attributes
import Html.Events
import InspectorModel.Entity exposing (Entity)
import Json.Decode
import Wheel
import Mouse
import Point
import View.WorldViewer.Model exposing (Model)
import View.WorldViewer.Message as Message


type alias IconName =
    String


entityIcon : Int -> String -> Point.Point -> Html.Html Message.Msg
entityIcon id iconName position =
    let
        translateString =
            "left: " ++ (toString <| Point.x position) ++ ", top:" ++ (toString <| Point.y position) ++ ")"

        scaleString =
            "scale(0.05)"

        transformString =
            String.join "," [ scaleString, translateString ]

        attributes =
            [ ( "left", ((toString (Point.x position)) ++ "px") ), ( "top", ((toString (Point.y position)) ++ "px") ) ]

        iconReference =
            Svg.use [ xlinkHref ("#" ++ iconName), Svg.Attributes.transform "scale(0.05)" ] []

        clickOptions =
            { stopPropagation = True
            , preventDefault = True
            }

        clickEvent =
            Html.Events.onWithOptions "click" clickOptions (Json.Decode.succeed (Message.ClickedSvgIcon id))

        svgIcon =
            Svg.svg [ class "icon-content", Svg.Attributes.viewBox "0 0 32 32" ] [ iconReference ]
    in
        div [ class "icon", Html.Attributes.style attributes, clickEvent ] [ svgIcon ]


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


handleMouseDown : Float -> Mouse.Event -> Message.Msg
handleMouseDown dummy event =
    Message.PointerStartTouchingViewer event.clientPos


mouseCoordinates : Mouse.Event -> ( Float, Float )
mouseCoordinates event =
    event.clientPos


backgroundSurface : Float -> List (Html.Html Message.Msg) -> Html.Html Message.Msg
backgroundSurface zoom children =
    let
        wheelEvent =
            (Wheel.onWheel (\event -> (Message.ZoomViewer <| zoom + event.deltaY * 0.01)))

        mouseDown =
            (Mouse.onDown (Message.PointerStartTouchingViewer << mouseCoordinates))

        mouseUp =
            (Mouse.onUp (Message.PointerStoppedTouchingViewer << mouseCoordinates))

        mouseMove =
            (Mouse.onMove (Message.PointerDraggingViewer << mouseCoordinates))
    in
        div [ class "icons", Html.Events.onClick (Message.ClickedSvgIcon 0), wheelEvent, mouseUp, mouseDown, mouseMove ] children


{-| Render entities both as svg icons and a property sheet.
-}
render : Model -> List Entity -> Html.Html Message.Msg
render model entities =
    let
        allIcons =
            (List.map
                (\entity ->
                    let
                        x =
                            entity.position.x * model.zoomLevel + 32

                        y =
                            entity.position.z * model.zoomLevel + 32

                        entityPos =
                            ( x, y )

                        totalOffset =
                            Point.add model.viewportOffset model.temporaryViewportOffset

                        adjustedPos =
                            Point.sub entityPos totalOffset

                        iconName =
                            iconNameFromType entity.ptype
                    in
                        (entityIcon entity.id iconName adjustedPos)
                )
                entities
            )
    in
        backgroundSurface model.zoomLevel allIcons
