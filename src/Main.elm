-----------------------
-- Anda-Corina Tilea
-- 16.11.2020
-----------------------

module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (..)
import Random
import Debug
import List exposing (foldl)
import Card exposing (..)
import String exposing (fromInt, concat)


main =
  Browser.element
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }


type alias Model =
  { hand: List Card,
    deck: List Card,
    showDeck: Bool
  }

startingModel : Model
startingModel =
    Model [] Card.deck True

init : () -> (Model, Cmd Msg)
init _ =
  (  startingModel
  , Cmd.none
  )


type Msg
  = Draw
  | NewCard Card
  | ToogleDeck

remove : a -> List a -> List a              -- helper implemented;
remove x xs =                               -- remove the first occurrence of an elem from the list xs;
    case xs of
        [] -> []
        y :: ys ->
            if x == y then ys
            else y :: remove x ys


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Draw ->
      ( model
      , drawCard model
      )
    
    -- Add the new card to the player's hand (`hand`) and remove it from the `deck`
    NewCard newCard ->
      ( { model
        | hand = newCard :: model.hand,
          deck = remove newCard model.deck }     -- remove the first occurrence of the value;
      , Cmd.none
      )

    -- Toggle (if it's `True` set it `False`, if it's `False` set it to `True`) the `showDeck` member of the `Model`
    ToogleDeck ->
      ( { model
        | showDeck = not model.showDeck }
      , Cmd.none
      )

drawCard : Model -> Cmd Msg
drawCard model =
  case model.deck of
    (first::rest) -> Random.generate NewCard (Random.uniform first rest)
    _ -> Cmd.none

{-
  1. Get the value of each card (use `cardValue`)
  2. Generate a list of all possible scores
  3. Return the score closest to 21 (less than 21!), if one exists, else the smallest score over 21
  ```elm
  calculateScore [Card King Hearts] == 10
  calculateScore [Card Two Hearts] == 2
  calculateScore [Card Two Hearts, Card King Spades] == 12
  calculateScore [Card Ace Hearts, Card King Spades] == 21
  calculateScore [Card Ace Hearts, Card Five Hearts, Card Seven Spades] == 13
  calculateScore [Card King Hearts, Card Five Hearts, Card Seven Spades] == 22
  calculateScore [Card King Hearts, Card Ten Clubs, Card Ace Spades] == 21
  calculateScore [Card Ace Spades, Card Ace Clubs, Card Ten Clubs, Card King Clubs] == 22
  ```
-}

getAceFree : List Card -> List Int      -- helper for obtaining the list of scores possible;
getAceFree cards =                      -- returns scores for all Cards excepting the Ace;
    case cards of
        [] -> []
        x::xs -> case x of
                  (Card Ace _) -> [] ++ getAceFree xs
                  (Card _ _) -> cardValue x ++ getAceFree xs


calculateScore : List Card -> Int
calculateScore cards =
    let
        -- helper for returning the score closest to 21;
        scoreHelper : Card -> Int -> Int
        scoreHelper card acc =
            case card of
                -- if the card we draw is an Ace, check what value should it have;
                (Card Ace _) -> if (foldl (+) 0 (getAceFree cards)) + 11 > 21       -- if the hand > 21
                                then acc + 1        -- Ace will be 1;
                                else acc + 11       -- else "soft" (a hand with an Ace valued as 11);
                -- if we draw any other card, normally obtain the score;
                (Card _ _) -> acc + (foldl (+) 0 (cardValue card))
    in
        foldl scoreHelper 0 cards


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

{-
  Use the `viewCard` function for showing the player's hand and the `cardToUnicode` function for the remaining deck.
-}
view : Model -> Html Msg
view model =
    let
      appName = "Blackjack"
      -- obtain the game status of the player;
      status = if (calculateScore model.hand == 21) then "BlackJack - You won!"
               else if (calculateScore model.hand < 21) then "Legal"
               else "Bust - You lose."
      showHand = List.map viewCard model.hand           -- showing the player's hand;
      showDeck  = List.map cardToUnicode model.deck     -- showing the remaining deck;
    in
      div []
        [  div [] [ h1 [] [text appName] ],
            -- display an appropriate message;
           div [] [h2 [] [ text ("Status : " ++ status)]],
           div [] [h2 [] [text ("Current Score: " ++
           fromInt(calculateScore model.hand))]],           -- show the score after its transformation in String;
           -- button for showing/hiding the current deck;
           button [onClick ToogleDeck] [text "Show/Hide Deck"],
           div [] [h1 [] [if model.showDeck then
           div [] [text ("Current Deck: " ++ concat showDeck)]
                         else div [] [] ]],
           -- button for drawing a new card;
           button [onClick Draw] [text "Draw Card"],
           div [] showHand
        ]

