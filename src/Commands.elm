module Commands exposing (..)

import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import Models exposing (Project)
import Msgs exposing (Msg)
import RemoteData


fetchProjects : Cmd Msg
fetchProjects =
    Http.get fetchProjectsUrl projectsDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchProjects


fetchProjectsUrl : String
fetchProjectsUrl =
    "https://api.github.com/repositories"


projectsDecoder : Decode.Decoder (List Project)
projectsDecoder =
    Decode.list projectDecoder


projectDecoder : Decode.Decoder Project
projectDecoder =
    decode Project
        |> required "id" Decode.int
        |> required "name" Decode.string
        |> required "url" Decode.string
