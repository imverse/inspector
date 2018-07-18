module Graphics.Graphics exposing (render)

{-| This library renders entities using svg.


# Render

@docs render

-}

import Svg exposing (..)
import Svg.Attributes exposing (..)
import Html
import InspectorModel.Entity exposing (Entity)


type alias IconName =
    String


entityIcon : String -> Float -> Float -> Svg msg
entityIcon iconName x y =
    let
        translateString =
            "translate(" ++ (toString x) ++ "," ++ (toString y) ++ ")"

        scaleString =
            "scale(0.05)"

        transformString =
            String.join "," [ scaleString, translateString ]
    in
        Svg.use [ xlinkHref ("#" ++ iconName), Svg.Attributes.transform transformString ] []


iconNameFromType : String -> IconName
iconNameFromType ptype =
    case ptype of
        "AttackMech" ->
            "robot"

        "SpaceGlider" ->
            "spaceship"

        _ ->
            "generic"


{-| Render entities both as svg icons and a property sheet.
-}
render : List Entity -> Html.Html msg
render entities =
    let
        allIcons =
            (List.map
                (\entity ->
                    let
                        x =
                            entity.position.x * 80.0

                        y =
                            entity.position.z * 80.0

                        iconName =
                            iconNameFromType entity.ptype
                    in
                        (entityIcon iconName x y)
                )
                entities
            )
    in
        svg [ class "viewer", fill "white", stroke "black", strokeWidth "3" ] allIcons
