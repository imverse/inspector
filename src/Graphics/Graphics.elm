module Graphics.Graphics exposing (render)

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
import Message


type alias IconName =
    String


entityIcon : String -> Float -> Float -> Svg Message.Msg
entityIcon iconName x y =
    let
        translateString =
            "left: " ++ (toString x) ++ ", top:" ++ (toString y) ++ ")"

        scaleString =
            "scale(0.05)"

        transformString =
            String.join "," [ scaleString, translateString ]

        attributes =
            [ ( "left", ((toString x) ++ "px") ), ( "top", ((toString y) ++ "px") ) ]

        iconReference =
            Svg.use [ xlinkHref ("#" ++ iconName), Svg.Attributes.transform "scale(0.05)" ] []
    in
        div [ class "icon", Html.Attributes.style attributes, Html.Events.onClick (Message.ClickedSvgIcon 2) ] [ Svg.svg [ class "icon-content", Svg.Attributes.viewBox "0 0 32 32" ] [ iconReference ] ]


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


{-| Render entities both as svg icons and a property sheet.
-}
render : List Entity -> Html.Html Message.Msg
render entities =
    let
        allIcons =
            (List.map
                (\entity ->
                    let
                        x =
                            entity.position.x * 2.0 + 32

                        y =
                            entity.position.z * 2.0 + 32

                        iconName =
                            iconNameFromType entity.ptype
                    in
                        (entityIcon iconName x y)
                )
                entities
            )
    in
        {- svg [ class "viewer", fill "white", stroke "black", strokeWidth "3" ] allIcons -}
        div [ class "icons" ] allIcons
