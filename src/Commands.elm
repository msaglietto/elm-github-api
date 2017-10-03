module Commands exposing (..)

import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, optional, required)
import Models exposing (Project, Route, SearchResult, User)
import Msgs exposing (Msg)
import RemoteData


fetchProjects : Route -> Cmd Msg
fetchProjects route =
    Http.get (fetchProjectsUrl route) searchDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchProjects


fetchProjectsUrl : Route -> String
fetchProjectsUrl route =
    case route of
        Models.Trending ->
            "https://api.github.com/search/repositories?q=elm&sort=stars&orer=desc"

        Models.Latest ->
            "https://api.github.com/search/repositories?q=elm&sort=updated&orer=desc"

        Models.NotFoundRoute ->
            ""


searchDecoder : Decode.Decoder SearchResult
searchDecoder =
    decode SearchResult
        |> required "total_count" Decode.int
        |> required "items" (Decode.list projectDecoder)


projectsDecoder : Decode.Decoder (List Project)
projectsDecoder =
    Decode.list projectDecoder


ownerDecoder : Decode.Decoder User
ownerDecoder =
    decode User
        |> required "id" Decode.int
        |> required "login" Decode.string
        |> required "html_url" Decode.string
        |> required "avatar_url" Decode.string


projectDecoder : Decode.Decoder Project
projectDecoder =
    decode Project
        |> required "id" Decode.int
        |> required "name" Decode.string
        |> required "html_url" Decode.string
        |> optional "description" Decode.string ""
        |> optional "forks_count" Decode.int 0
        |> optional "stargazers_count" Decode.int 0
        |> optional "topics" (Decode.list Decode.string) []
        |> required "owner" ownerDecoder
