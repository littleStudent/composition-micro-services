module Main exposing (..)

import Html exposing (..)
import Http
import Json.Decode as Decode


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { animals : List String
    }


init : ( Model, Cmd Msg )
init =
    ( Model [], getAnimals )



-- UPDATE


type Msg
    = Animal_Response (Result Http.Error (List String))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Animal_Response (Ok newAnimal) ->
            ( { model | animals = newAnimal }, Cmd.none )

        Animal_Response (Err _) ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ h2 [] [ text "animals" ]
        , div [] (List.map (\animal -> p [] [ text animal ]) model.animals)
        ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- HTTP


getAnimals : Cmd Msg
getAnimals =
    Http.send Animal_Response (Http.get "api/" (Decode.list Decode.string))
