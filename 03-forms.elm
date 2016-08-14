import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)

import String
import Regex



main =
  Html.beginnerProgram { model = model, view = view, update = update }



-- MODEL


type alias Model =
  { age : Maybe Int
  , name : String
  , password : String
  , passwordAgain : String
  , validationMessage : String
  , validationColor : String
  }

model : Model
model =
  Model Nothing "" "" "" "" ""


-- UPDATE


type Msg
  = Age String
  | Name String
  | Password String
  | PasswordAgain String
  | Validate


update : Msg -> Model -> Model
update msg model =
  case msg of
    Age age ->
      { model | age = Result.toMaybe <| (String.toInt age) }

    Name name ->
      { model | name = name }

    Password password ->
      { model | password = password }

    PasswordAgain password ->
      { model | passwordAgain = password }

    Validate ->
      viewValidation model

-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ input [ type' "text", placeholder "Name", onInput Name ] []
    , input [ type' "number", placeholder "Age", onInput Age ] []
    , input [ type' "password", placeholder "Password", onInput Password ] []
    , input [ type' "password", placeholder "Re-enter Password", onInput PasswordAgain ] []
    , button [ onClick Validate ] [ text "Submit" ]
    , div [ style [("color", model.validationColor)] ] [ text model.validationMessage ]
    ]

viewValidation : Model -> Model
viewValidation model =
  if model.age == Nothing then
    { model | validationColor = "red",
              validationMessage = "Age must be a number" }
  else if Maybe.withDefault 0 model.age < 21 then
    { model | validationColor = "red",
              validationMessage = "Must be at least 21 years of age" }
  else if model.password /= model.passwordAgain then
    { model | validationColor = "red",
              validationMessage = "Passwords do not match" }
  else if String.length model.password < 8 then
    { model | validationColor = "red",
              validationMessage = "Passwords must be at least 8 characters in length" }
  else if not (Regex.contains (Regex.regex "[A-Z]+") model.password) then
    { model | validationColor = "red",
              validationMessage = "Passwords must contain an upper case character" }
  else if not (Regex.contains (Regex.regex "[a-z]+") model.password) then
    { model | validationColor = "red",
              validationMessage = "Passwords must contain a lower case character" }
  else if not (Regex.contains (Regex.regex "[0-9]+") model.password) then
    { model | validationColor = "red",
              validationMessage = "Passwords must contain a numeric character" }
  else
    { model | validationColor = "green",
              validationMessage = "OK" }
