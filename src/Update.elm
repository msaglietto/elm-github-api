module Update exposing (..)

import Commands exposing (fetchProjects)
import Models exposing (Model)
import Msgs exposing (Msg)
import Routing exposing (parseLocation)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msgs.OnFetchProjects response ->
            ( { model | results = response }, Cmd.none )

        Msgs.OnLocationChange location ->
            let
                newRoute =
                    parseLocation location
            in
            ( { model | route = newRoute }, fetchProjects newRoute )
