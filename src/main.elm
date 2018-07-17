module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Entity
import Property
import EntityUi
import Component
import PropertyTableUi
import Ports
import EntityDto
import Model exposing (Model)
import EntityDtoToModel


subscriptions : Model -> Sub Msg
subscriptions model =
    Ports.replicationToElm UpdateStr


testProperties : List Property.Property
testProperties =
    [ Property.Property "Example Name" (Property.Base (Property.BaseInt 42))
    , Property.Property "Structured Name"
        (Property.Structured
            (Property.Structure "Vector2D"
                [ Property.Field "x" (Property.BaseFloat 2.3)
                , Property.Field "y" (Property.BaseFloat 2.5)
                ]
            )
        )
    , Property.Property "Another Name" (Property.Base (Property.BaseString "My Name"))
    ]


testStructure : Property.Structure
testStructure =
    (Property.Structure "Vector3f"
        [ Property.Field "x" (Property.BaseFloat 1.5)
        , Property.Field "y" (Property.BaseFloat 2.6)
        , Property.Field "z" (Property.BaseFloat 3.7)
        ]
    )


tileStructure : Property.Structure
tileStructure =
    (Property.Structure "Gfx"
        [ Property.Field "tileIndex" (Property.BaseFloat 99)
        ]
    )


testComponents : List Component.Component
testComponents =
    [ (Component.Component "body" [ (Component.Field "position" testStructure), (Component.Field "rotation" testStructure) ])
    , (Component.Component "gfx" [ (Component.Field "tileData" tileStructure) ])
    ]


testEntities : String -> List Entity.Entity
testEntities name =
    [ (Entity.Entity 2 name testComponents)
    , (Entity.Entity 3 "AnotherEntity" testComponents)
    ]


hackInsertCssLink : Html msg -> List (Html msg)
hackInsertCssLink children =
    [ node "link" [ rel "stylesheet", href "style.css" ] []
    , children
    ]


entityTable : Model -> Html msg
entityTable model =
    let
        entityElements =
            (EntityUi.renderEntityRows model.entities)
    in
        (PropertyTableUi.renderPropertyTable entityElements)


view : Model -> Html Msg
view model =
    div [] (hackInsertCssLink (entityTable model))


type Msg
    = UpdateStr EntityDto.Root


initModel : Model
initModel =
    Model (testEntities "FirstEntity")


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
