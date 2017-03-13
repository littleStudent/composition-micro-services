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
    { recipes : List String
    }


init : ( Model, Cmd Msg )
init =
    ( Model [], getRecipes )



-- UPDATE


type Msg
    = Recipe_Response (Result Http.Error (List String))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Recipe_Response (Ok newRecipes) ->
            ( { model | recipes = newRecipes }, Cmd.none )

        Recipe_Response (Err _) ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ h2 [] [ text "test" ]
        , div [] (List.map (\recipe -> p [] [ text recipe ]) model.recipes)
        ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- HTTP


getRecipes : Cmd Msg
getRecipes =
    Http.send Recipe_Response (Http.get "api/" (Decode.list Decode.string))
