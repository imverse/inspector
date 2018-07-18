module Graphics exposing (..)

import Svg exposing (..)
import Svg.Attributes exposing (..)
import Html
import Html.Attributes
import Entity


entityIcon : Float -> Float -> Svg msg
entityIcon x y =
    Svg.path [ Svg.Attributes.d "M 256 0 l -256 256 l 256 256 l 256 -256 l -256 -256 z", Svg.Attributes.style "fill: #55aa55; stroke: #ff3322", Svg.Attributes.transform ("scale(0.05),translate(" ++ (toString x) ++ "," ++ (toString y) ++ ")") ] []


render : List Entity.Entity -> Html.Html msg
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
                    in
                        (entityIcon x y)
                )
                entities
            )
    in
        svg [ class "viewer", fill "white", stroke "black", strokeWidth "3" ] allIcons
