import Html exposing (Html)
import Html.App as App
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Svg.Events exposing (onClick)
import Time exposing (Time, second)


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
      [ drawClock model, drawButton ]

drawClock : Model -> Svg Msg
drawClock model =
  let
    time = if model.power then model.time else 0
    angle =
      turns (Time.inMinutes time)

    handX =
      toString (50 + 40 * cos angle)

    handY =
      toString (50 + 40 * sin angle)
  in
    g []
      [ circle [ cx "50", cy "50", r "45", fill "#0B79CE" ] []
      , line [ x1 "50", y1 "50", x2 handX, y2 handY, stroke "#023963"] []
      ]

drawButton : Svg Msg
drawButton =
  g [ Svg.Attributes.cursor "pointer"
    , onClick Power
    ]
    [
     rect [ fill "none"
          , stroke "black"
          , x "25"
          , y "120"
          , width "50"
          , height "10"
          , rx "2"
          , ry "2" ] [ ]
    , text' [ x "30"
            , y "128"
            , fontFamily "arial"
            , fontSize "9"
            ] [ text "Start/Stop" ]
    ]
