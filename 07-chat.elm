import Html exposing (..)
import Html.App as Html
import Html.Events exposing (..)
import WebSocket

main : Program Never
main =
  Html.program { init = init
               , update = update
               , subscriptions = subscriptions
               , view = view
               }


-- MODEL

type alias Model =
  { input : String
  , messages : List String
  }


-- INIT

init : (Model, Cmd Msg)
init =
  (Model "" [], Cmd.none)


-- UPDATE

type Msg
  = Input String
  | Send
  | NewMessage String

update : Msg -> Model -> (Model, Cmd Msg)
update msg {input, messages} =
  case msg of
    Input newInput ->
      (Model newInput messages, Cmd.none)
    Send ->
      (Model "" messages, WebSocket.send "ws://echo.websocket.org" input)
    NewMessage str ->
      (Model input (str :: messages), Cmd.none)



-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  WebSocket.listen "ws://echo.websocket.org" NewMessage


-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ div [] (List.map viewMessage model.messages)
    , input [onInput Input] []
    , button [onClick Send] [text "Send"]
    ]

viewMessage : String -> Html msg
viewMessage msg =
  div [] [ text msg ]
