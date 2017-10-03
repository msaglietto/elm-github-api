module Projects.List exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href)
import Models exposing (Project, SearchResult)
import Msgs exposing (Msg)
import RemoteData exposing (WebData)


view : WebData SearchResult -> Html Msg
view response =
    div []
        [ maybeList response ]


maybeList : WebData SearchResult -> Html Msg
maybeList response =
    case response of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading..."

        RemoteData.Success result ->
            list result.items

        RemoteData.Failure error ->
            text (toString error)


list : List Project -> Html Msg
list projects =
    div [ class "list-group" ]
        (List.map
            projectItem
            projects
        )


projectItem : Project -> Html Msg
projectItem project =
    a
        [ href "#", class "list-group-item list-group-item-action flex-column align-items-start" ]
        [ div [ class "d-flex w-100 justify-content-between" ]
            [ h5 [ class "mb-1" ]
                [ text project.name ]
            , small []
                [ text "Stars "
                , span [ class "badge badge-primary" ] [ text (toString project.stargazer_count) ]
                , text " Forks "
                , span [ class "badge badge-info" ] [ text (toString project.forks_count) ]
                ]
            ]
        , p [ class "mb-1" ]
            [ text project.description ]
        , small [ class "text-muted" ]
            [ text project.owner.login ]
        ]
