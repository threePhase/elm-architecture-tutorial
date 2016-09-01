import Tree exposing (..)
import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (style)


main : Program Never
main =
  Html.program { init = init
               , subscriptions = subscriptions
               , update = update
               , view = view
               }


-- MODEL

type alias Model =
  { deepTree : Tree Int
  , niceTree : Tree Int
  }



-- INIT

init : (Model, Cmd Msg)
init =
  let model =
    { deepTree = fromList [1,2,3]
    , niceTree = fromList [2,1,3]
    }
  in
    (model, Cmd.none)


-- UPDATE

type Msg = Nothing

update : Msg -> Model -> (Model, Cmd Msg)
update msg model = (model, Cmd.none)


-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model = Sub.none


-- VIEW

view : Model -> Html Msg
view model =
  let
    deepTree = model.deepTree
    niceTree = model.niceTree
  in
    div [style [ ("font-family", "monospace") ] ]
      [ display "deepTree" deepTree
      , display "niceTree" niceTree
      , display "depth deepTree" (depth deepTree)
      , display "depth niceTree" (depth niceTree)
      , display "incremented deepTree" (map (\n -> n + 1) deepTree)
      , display "incremented niceTree" (map (\n -> n + 1) niceTree)
      , display "summed deepTree" (sum deepTree)
      , display "summed niceTree" (sum niceTree)
      , display "flattened deepTree" (flatten deepTree)
      , display "flattened niceTree" (flatten niceTree)
      , display "1 isElement of deepTree" (isElement 1 deepTree)
      , display "7 isElement of niceTree" (isElement 7 niceTree)
      ]

display : String -> a -> Html msg
display name value =
  div [] [ text (name ++ " ==> " ++ toString value)]
