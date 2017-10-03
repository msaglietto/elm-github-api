module Models exposing (..)

import RemoteData exposing (WebData)


type alias Model =
    { projects : WebData (List Project) }


initialModel : Model
initialModel =
    { projects = RemoteData.Loading }


type alias Project =
    { id : Int
    , url : String
    , name : String
    }
