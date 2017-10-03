module Models exposing (..)

import RemoteData exposing (WebData)


type alias Model =
    { results : WebData SearchResult
    , route : Route
    }


initialModel : Route -> Model
initialModel route =
    { results = RemoteData.Loading
    , route = route
    }


type alias Project =
    { id : Int
    , name : String
    , html_url : String
    , description : String
    , forks_count : Int
    , stargazer_count : Int
    , topics : List String
    , owner : User
    }


type alias User =
    { id : Int
    , login : String
    , html_url : String
    , avatar_url : String
    }


type alias SearchResult =
    { total_count : Int
    , items : List Project
    }


type Route
    = Latest
    | Trending
    | NotFoundRoute
