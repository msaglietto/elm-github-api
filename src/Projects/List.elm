module Projects.List exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class)
import Models exposing (Project)
import Msgs exposing (Msg)
import RemoteData exposing (WebData)


view : WebData (List Project) -> Html Msg
view response =
    div []
        [ nav
        , maybeList response
        ]


maybeList : WebData (List Project) -> Html Msg
maybeList response =
    case response of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading..."

        RemoteData.Success projects ->
            list projects

        RemoteData.Failure error ->
            text (toString error)


nav : Html Msg
nav =
    div [ class "" ]
        [ div [ class "" ] [ text "Projects" ] ]


list : List Project -> Html Msg
list projects =
    div [ class "" ]
        [ ul []
            (List.map
                projectItem
                projects
            )
        ]


projectItem : Project -> Html Msg
projectItem project =
    li [] [ text project.name ]
