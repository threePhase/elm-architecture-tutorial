import Html exposing (..)
import Html.App as Html
import Html.Events exposing (onClick)

import Random

main =
  Html.program { init = init, update = update, subscriptions = subscriptions, view = view}

-- MODEL

type alias Model =
  { dieFace : Int
  }

model : Model
model =
  { dieFace = 1 }


-- UPDATE

type Msg
  = Roll
  | NewFace Int

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Roll ->
      (model, Random.generate NewFace (Random.int 1 6))

    NewFace newFace ->
      (Model newFace, Cmd.none)


-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ h1 [] [ text (toString model.dieFace) ]
    , button [ onClick Roll ] [ text "Roll" ]
    ]


-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model = Sub.none



-- INIT

init : (Model, Cmd Msg)
init =
  (Model 1, Cmd.none)
