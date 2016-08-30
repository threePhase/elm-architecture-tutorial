import Html exposing (..)
import Html.App as Html
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)

import Random
import List exposing (map, repeat)

main =
  Html.program { init = init, update = update, subscriptions = subscriptions, view = view}

-- MODEL

type alias Die =
  { dieFace : Int }

type alias Model =
  List Die

model : Model
model = [Die 1, Die 1]


-- UPDATE

type Msg
  = Roll
  | NewFace (Int, Int)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Roll ->
      (model, Random.generate NewFace (Random.pair (Random.int 1 6) (Random.int 1 6)))

    NewFace (newFace1, newFace2) ->
      ([Die newFace1, Die newFace2], Cmd.none)


-- VIEW

view : Model -> Html Msg
view model =
  div [ style [ ("display", "flex")
              , ("flex-direction", "column")
              , ("height", "50%")
              , ("text-align", "center")
              , ("width", "50%")
              ]
      ]
    [ div [ style [ ("display", "flex")
                  , ("flex-direction", "row")
                  ]
          ] (map displayDie model)
    , button [ onClick Roll ] [ text "Roll" ]
    ]

displayDie : Die -> Html Msg
displayDie die =
  div [ style [ ("margin", "10%")
              , ("flex", "1 1 auto")
              --, ("margin-right", "10%")
              ]
      ]
    [ h1 [] [ text (toString die.dieFace) ]
    , displayDieFace die
    ]

displayDieFace : Die -> Html msg
displayDieFace die =
  let
    dots = die.dieFace
  in
    div [ style [ ("width", "100px")
                , ("height", "100px")
                , ("flex-wrap", "wrap")
                , ("flex-direction", "row")
                , ("display", "flex")
                , ("border", "black 5px solid")
                , ("border-radius", "5px")
                ]
        ]
      (repeat dots (div [ style [ ("width", "20px")
                                , ("height", "20px")
                                , ("margin", "6%")
                                , ("flex", "0 0 auto")
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
  ([Die 1, Die 1], Cmd.none)
