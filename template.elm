import Html exposing (..)
import Html.App as Html


main =
  Html.program { init = init, update = update, subscriptions = subscriptions, view = view}

-- MODEL

type alias Model =
  { ...
  }


-- UPDATE

type Msg = Submit | ...

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  ...


-- VIEW

view : Model -> Html Msg
view model =
  ...


-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model = Sub.none



-- INIT

init : (Model, Cmd Msg)
init =
  ...
