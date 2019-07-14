import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)



-- MAIN


main =
  Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
  { name : String,
    list: List String
  }


init : Model
init =
  Model "" []


-- UPDATE


type Msg
  = Name String | Add String | Remove String


update : Msg -> Model -> Model
update msg model =
    case msg of
    Name name ->
        { model | name = name }

    Add list ->
        { model | list = List.append model.list [list], name = ""}

    Remove remove->
        { model | list = List.filter (\x -> not (String.contains remove x)) model.list}


-- VIEW


view : Model -> Html Msg
view model =
      div []
        [ viewInput "text" "Name" model.name Name
        , button [ onClick (Add model.name) ] [ text "Add to list" ]
        , ul
            []
            (List.map renderList [model.list])
        ]

renderList : List String -> Html Msg
renderList lst =
    ul []
        (List.map (\l -> li [] [ text l, button [ onClick (Remove l) ] [ text "Remove" ]]) lst)


viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
  input [ type_ t, placeholder p, value v, onInput toMsg ] []
