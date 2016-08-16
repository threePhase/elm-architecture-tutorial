import Html exposing (Html)
import Html.App as App
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Time exposing (Time, second)


main =
  App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


-- MODEL

type alias Model = Time


init : (Model, Cmd Msg)
init =
  (0, Cmd.none)


-- UPDATE

type Msg
  = Tick Time


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Tick newTime ->
      (newTime, Cmd.none)


-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  Time.every second Tick


-- VIEW

view : Model -> Html Msg
view model =
    svg [ viewBox "0 0 100 150", width "300px" ]
      [ drawClock model, drawButton ]

drawClock : Model -> Svg msg
drawClock model =
  let
    angle =
      turns (Time.inMinutes model)

    handX =
      toString (50 + 40 * cos angle)

    handY =
      toString (50 + 40 * sin angle)
  in
    g []
      [ circle [ cx "50", cy "50", r "45", fill "#0B79CE" ] []
      , line [ x1 "50", y1 "50", x2 handX, y2 handY, stroke "#023963"] []
      ]

drawButton : Svg msg
drawButton =
  g [ Svg.Attributes.cursor "pointer" ]
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
