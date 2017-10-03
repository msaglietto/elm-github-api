module Msgs exposing (..)

import Models exposing (SearchResult)
import Navigation exposing (Location)
import RemoteData exposing (WebData)


type Msg
    = OnFetchProjects (WebData SearchResult)
    | OnLocationChange Location
