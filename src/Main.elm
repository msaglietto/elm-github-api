module Main exposing (..)

import Commands exposing (fetchProjects)
import Models exposing (Model, initialModel)
import Msgs exposing (Msg)
import Navigation exposing (Location)
import Routing
import Update exposing (update)
import View exposing (view)


init : Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute =
            Routing.parseLocation location
    in
    ( initialModel currentRoute, fetchProjects currentRoute )


main : Program Never Model Msg
main =
    Navigation.program Msgs.OnLocationChange
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
