module Main exposing (..)

import Commands exposing (fetchProjects)
import Html exposing (Html, div, img, text)
import Models exposing (Model, initialModel)
import Msgs exposing (Msg)
import Projects.List


---- MODEL ----


init : ( Model, Cmd Msg )
init =
    ( initialModel, fetchProjects )



---- UPDATE ----


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msgs.OnFetchProjects response ->
            ( { model | projects = response }, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ Projects.List.view model.projects ]



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
