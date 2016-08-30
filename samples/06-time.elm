import Html exposing (Html)
import Html.App as App
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Svg.Events exposing (onClick)
import Time exposing (Time, second)

main : Program Never
main =
  App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


-- MODEL

type alias Model =
  { power : Bool
  , time : Time
  }


init : (Model, Cmd Msg)
init =
  let model =
    { power = True
    , time = 0
    }
    in
  (model, Cmd.none)


-- UPDATE

type Msg
  = Tick Time
  | Power


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Tick newTime ->
      ({ model | time = newTime }, Cmd.none)
    Power ->
      ({ model | power = (not model.power) }, Cmd.none)


-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  Time.every second Tick


-- VIEW

view : Model -> Html Msg
view model =
    svg [ viewBox "0 0 100 150", width "300px" ]
      [ drawClock model, drawButton model ]

drawClock : Model -> Svg Msg
drawClock model =
  let
    tzOffsetInHours = -7
    millisecondsInHour = 3600 * 1000
    offset = tzOffsetInHours * millisecondsInHour
    time = if model.power then (model.time + offset) else 0
    hours = (truncate (Time.inHours time)) % 24
    minutes = (truncate (Time.inMinutes time)) % 60
    seconds = (truncate (Time.inSeconds time)) % 60
  in
    g []
      [ circle [ cx "50", cy "50", r "45", fill "#0B79CE" ] []
      , drawHoursHand <| toFloat hours
      , drawMinutesHand <| toFloat minutes
      , drawSecondsHand <| toFloat seconds
      ]

drawSecondsHand : Float -> Svg Msg
drawSecondsHand seconds =
  let
    angle =
      turns ((seconds / 60) - (1 / 4))

    handX =
      toString (50 + 40 * cos angle)

    handY =
      toString (50 + 40 * sin angle)
  in
    line [ x1 "50"
         , y1 "50"
         , x2 handX
         , y2 handY
         , stroke "#dd2222"
         ] []

drawMinutesHand : Float -> Svg Msg
drawMinutesHand minutes =
  let
    angle =
      turns ((minutes / 60) - (1 / 4))

    handX =
      toString (50 + 30 * cos angle)

    handY =
      toString (50 + 30 * sin angle)
  in
    line [ x1 "50"
         , y1 "50"
         , x2 handX
         , y2 handY
         , stroke "#023963"
         , strokeWidth "2"
         ] []

drawHoursHand : Float -> Svg Msg
drawHoursHand hours =
  let
    angle =
      turns ((hours / 12) - (1 / 4))

    handX =
      toString (50 + 25 * cos angle)

    handY =
      toString (50 + 25 * sin angle)
  in
    line [ x1 "50"
         , y1 "50"
         , x2 handX
         , y2 handY
         , stroke "#023963"
         , strokeWidth "4"
         ] []

drawButton : Model -> Svg Msg
drawButton model =
  let
    buttonText = if model.power then "Stop" else "Start"
  in
    g [ Svg.Attributes.cursor "pointer"
      , onClick Power
      ]
    [
     rect [ fill "none"
          , stroke "black"
          , x "35"
          , y "120"
          , width "30"
          , height "10"
          , rx "2"
          , ry "2"
          ] [ ]
    , text' [ x "40"
            , y "128"
            , fontFamily "arial"
            , fontSize "9"
            ] [ text buttonText ]
    ]
