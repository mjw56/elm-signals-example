module Main where

import Html exposing (..)
import Html.Events exposing (onClick)

type alias Message = String
type alias Messages = List String
type alias Model = {
    messages: Messages,
    requests: Int
}

type Action = NoOp | UpdateRequest

updateRequestMailbox : Signal.Mailbox Action
updateRequestMailbox = Signal.mailbox NoOp

port updateRequests : Signal String
port updateRequests =
  Signal.map (\_ -> "updateRequest") updateRequestMailbox.signal

port newMessages : Signal Messages

updateMessages : Signal (Model -> Model)
updateMessages =
  Signal.map
    (\messages -> (\model -> { model | messages = messages, requests = model.requests + 1 }))
    newMessages

update : (Model -> Model) -> Model -> Model
update folder model =
  folder model

updateRequestButton : Html
updateRequestButton =
  button
    [
      onClick updateRequestMailbox.address UpdateRequest
    ]
    [text "request update"]

messageView : Message -> Html
messageView message =
  div [] [text message]

messagesView : Messages -> Html
messagesView messages =
  div [] (List.map (\n -> messageView n) messages)

view : Model -> Html
view model =
  div []
    [
      h3 [] [text "Messages:"],
      updateRequestButton,
      h4 [] [text ("# of requests from JS to Elm: " ++ (toString model.requests))],
      messagesView model.messages
    ]

model =
  {
    messages = [],
    requests = 0
  }

main =
  Signal.mergeMany
    [
      updateMessages
    ]
  |> Signal.foldp update model
  |> Signal.map view