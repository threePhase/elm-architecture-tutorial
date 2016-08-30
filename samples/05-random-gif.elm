import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (placeholder, src, style, type')
import Html.Events exposing (onClick, onInput)

import Http
import Json.Decode as Json
import Task

main =
  Html.program { init = init, update = update, subscriptions = subscriptions, view = view}

-- MODEL

type alias Model =
  { topic : String
  , gifUrl : String
  , error : Maybe Http.Error
  }


-- UPDATE

type Msg
  = MorePlease
  | FetchSucceed String
  | FetchFail Http.Error
  | Topic String

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    MorePlease ->
      (model, getRandomGif model.topic)

    FetchSucceed newUrl ->
      (Model model.topic newUrl Nothing, Cmd.none)

    FetchFail error ->
      (Model model.topic "waiting.gif" (Just error), Cmd.none)

    Topic topic ->
      ({ model | topic = topic }, Cmd.none)

getRandomGif : String -> Cmd Msg
getRandomGif topic =
  let
    url =
      "https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=" ++ topic
  in
    Task.perform FetchFail FetchSucceed (Http.get decodeGifUrl url)

decodeGifUrl : Json.Decoder String
decodeGifUrl =
  Json.at ["data", "image_url"] Json.string


-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ h2 [] [ text model.topic ]
    , img [ src model.gifUrl ] []
    , input [ type' "text", placeholder "Topic", onInput Topic] []
    , button [ onClick MorePlease ] [ text "More Please!" ]
    , viewValidation model
    ]

viewValidation : Model -> Html msg
viewValidation model =
  let
    message =
      case model.error of
        Just Http.Timeout ->
          "Network connection timed out"

        Just Http.NetworkError ->
          "A network error occurred"

        Just (Http.UnexpectedPayload message) ->
          "An unexpected payload was received: " ++ message

        Just (Http.BadResponse code message) ->
          "Bad Response: " ++ message ++ " | status: " ++ message

        Nothing ->
          ""
  in
    div [ style [("color", "red")] ] [ text message ]

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model = Sub.none



-- INIT

init : (Model, Cmd Msg)
init =
  (Model "cats" "waiting.gif" Nothing, Cmd.none)
