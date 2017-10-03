module View exposing (..)

import Html exposing (Html, a, div, li, span, text, ul)
import Html.Attributes exposing (class, href)
import Models exposing (Model)
import Msgs exposing (Msg)
import Projects.List


view : Model -> Html Msg
view model =
    div []
        [ nav model
        , page model
        ]


nav : Model -> Html Msg
nav model =
    let
        trendingActive =
            case model.route of
                Models.Trending ->
                    "active"

                _ ->
                    ""

        latestActive =
            case model.route of
                Models.Latest ->
                    "active"

                _ ->
                    ""
    in
    Html.nav [ class "navbar navbar-expand-lg navbar-light bg-light" ]
        [ span [ class "h1" ]
            [ text "GitHub Elm Projects" ]
        , div [ class "collapse navbar-collapse" ]
            [ ul [ class "navbar-nav mr-auto" ]
                [ li [ class ("nav-item " ++ trendingActive) ]
                    [ a [ class "nav-link", href "#/trending" ]
                        [ text "Trending" ]
                    ]
                , li [ class ("nav-item" ++ latestActive) ]
                    [ a [ class "nav-link", href "#/latest" ]
                        [ text "Latest" ]
                    ]
                ]
            ]
        ]


page : Model -> Html Msg
page model =
    case model.route of
        Models.Latest ->
            Projects.List.view model.results

        Models.Trending ->
            Projects.List.view model.results

        Models.NotFoundRoute ->
            notFoundView


notFoundView : Html msg
notFoundView =
    div []
        [ text "Not found"
        ]
