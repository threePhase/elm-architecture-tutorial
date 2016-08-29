import Html exposing (..)
import Html.App as Html


main : Program Never
main =
  Html.program { init = init
               , update = update
               , subscriptions = subscriptions
               , view = view
               }


-- MODEL

type alias Model =
  { ...
  }


-- INIT

init : (Model, Cmd Msg)
init =
  ...


-- UPDATE

type Msg = Submit | ...

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  ...


-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model = Sub.none


-- VIEW

view : Model -> Html Msg
view model =
  ...
