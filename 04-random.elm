import Html exposing (Html, button, div, h1, text)
import Html.App as Html
import Html.Events exposing (onClick)

main =
  Html.beginnerProgram { model = model, view = view, update = update } --, init = init }

-- MODEL

type alias Model =
  { dieFace : Int
  }
model =
  { dieFace = 1 }


-- UPDATE

type Msg = Roll

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Roll ->
      (model, Cmd.none)


-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ h1 [] [ text (toString model.dieFace) ]
    , button [ onClick Roll ] [ text "Roll" ]
    ]


-- SUBSCRIPTIONS

--subscriptions : Model -> Sub Msg
--subscriptions model =
--  ...



-- INIT

init : (Model, Cmd Msg)
init =
  (Model 1, Cmd.none)
