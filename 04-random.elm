import Html exposing (..)
import Html.App as Html
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)

import Random
import List exposing (repeat)

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
    , displayDieFace model
    , button [ onClick Roll ] [ text "Roll" ]
    ]

displayDieFace : Model -> Html msg
displayDieFace model =
  let
    dots = model.dieFace
  in
    div [ style [ ("width", "100px")
                , ("height", "100px")
                , ("border", "black 5px solid")
                , ("border-radius", "5px")
                ]
        ]
      (repeat dots (div [ style [ ("width", "20px")
                                , ("height", "20px")
                                , ("margin", "6%")
                                , ("display", "inline-block")
                                , ("background", "black")
                                , ("border-radius", "20px")
                                ]
                         ] []
                   )
      )


-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model = Sub.none



-- INIT

init : (Model, Cmd Msg)
init =
  (Model 1, Cmd.none)
