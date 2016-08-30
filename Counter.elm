module Counter exposing (Model, Msg, init, update, view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


-- MODEL

type alias Model =
  { count : Int
  , maxCount : Int
  , minCount : Int
  }


-- INIT

init : Int -> Model
init count =
  Model count count count


-- UPDATE

type Msg
  = Increment
  | Decrement

update : Msg -> Model -> Model
update msg model =
  case msg of
    Increment ->
      let newCount = model.count + 1
      in
        { model | count = newCount
                , maxCount = if newCount > model.maxCount then
                              newCount
                            else
                              model.maxCount }

    Decrement ->
      let newCount = model.count - 1
      in
        { model | count = model.count - 1
                , minCount = if newCount < model.minCount then
                              newCount
                            else
                              model.minCount }

-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ button [ onClick Decrement ] [ text "-" ]
    , div [ countStyle ] [ text <| toString model.count ]
    , button [ onClick Increment ] [ text "+" ]
    , div [ ] [ text <| "Max Count: " ++ toString model.maxCount ]
    , div [ ] [ text <| "Min Count: " ++ toString model.minCount ]
    ]


countStyle : Attribute msg
countStyle =
  style
    [ ("display", "inline-block")
    , ("font-family", "monospace")
    , ("font-size", "20px")
    , ("text-align", "center")
    , ("width", "50px")
    ]
