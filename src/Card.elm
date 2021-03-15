-----------------------
-- Anda-Corina Tilea
-- 16.11.2020
-----------------------

module Card exposing (..)

import Html exposing (..)
import Html.Attributes exposing (style)

{-
  Replace with your definitions from assignment 1
-}
type Face = Ace | Two | Three | Four | Five | Six | Seven | Eight | Nine | Ten | Jack | Queen | King

type Suit = Clubs | Diamonds | Hearts | Spades

type Card = Card Face Suit

faceToString : Face -> String
faceToString face = case face of
                            Ace -> "Ace"
                            Two -> "Two"
                            Three -> "Three"
                            Four -> "Four"
                            Five -> "Five"
                            Six -> "Six"
                            Seven -> "Seven"
                            Eight -> "Eight"
                            Nine -> "Nine"
                            Ten -> "Ten"
                            Jack -> "Jack"
                            Queen -> "Queen"
                            King -> "King"

suitToString : Suit -> String
suitToString suit = case suit of
                            Clubs -> "Clubs"
                            Diamonds -> "Diamonds"
                            Hearts -> "Hearts"
                            Spades -> "Spades"

cardToString : Card -> String
cardToString card =
    let (Card face suit) = card
    in
        faceToString(face) ++ " of " ++ suitToString(suit)

cardValue : Card -> List Int
cardValue card =
    case card of
            (Card Two _ ) -> 2 :: []
            (Card Three _ ) -> 3 :: []
            (Card Four _ ) -> 4 :: []
            (Card Five _ ) -> 5 :: []
            (Card Six _ ) -> 6 :: []
            (Card Seven _ ) ->  7 :: []
            (Card Eight _ ) -> 8 :: []
            (Card Nine _ ) -> 9 :: []
            (Card Ten _ ) -> 10 :: []
            (Card Jack _ ) -> 10 :: []
            (Card Queen _ ) -> 10 :: []
            (Card King _ ) -> 10 :: []
            (Card Ace _ ) -> 1 :: 11 :: []


fullFace : Face -> List Card
fullFace f = [Card f Clubs, Card f Diamonds, Card f Hearts, Card f Spades]


deck : List Card
deck = List.concat [fullFace Ace, fullFace Two, fullFace Three, fullFace Four, fullFace Five, fullFace Six, fullFace Seven, fullFace Eight
                                   , fullFace Nine, fullFace Ten, fullFace Jack, fullFace Queen, fullFace King]

{-
  Modify this function (if needed) to work with your `Card` definition
-}
cardToUnicode : Card -> String
cardToUnicode (Card face suit) =
   case face of
     Ace -> case suit of
       Spades ->"🂡"
       Hearts -> "🂱"
       Clubs ->  "🃑"
       Diamonds -> "🃁"
     Two -> case suit of
       Spades ->"🂢"
       Hearts -> "🂲"
       Clubs ->  "🃒"
       Diamonds -> "🃂"
     Three -> case suit of
       Spades ->"🂣"
       Hearts -> "🂳"
       Clubs ->  "🃓"
       Diamonds ->"🃃"
     Four -> case suit of
       Spades ->"🂤"
       Hearts -> "🂴"
       Clubs ->  "🃔"
       Diamonds -> "🃄"
     Five -> case suit of
       Spades ->"🂥"
       Hearts -> "🂵"
       Clubs ->  "🃕"
       Diamonds -> "🃅"
     Six -> case suit of
       Spades ->"🂦"
       Hearts -> "🂶"
       Clubs ->  "🃖"
       Diamonds -> "🃆"
     Seven -> case suit of
       Spades ->"🂧"
       Hearts -> "🂷"
       Clubs ->  "🃗"
       Diamonds -> "🃇"
     Eight -> case suit of
       Spades -> "🂨"
       Hearts ->  "🂸"
       Clubs ->   "🃘"
       Diamonds ->  "🃈"
     Nine -> case suit of
       Spades -> "🂩"
       Hearts ->  "🂹"
       Clubs ->   "🃙"
       Diamonds ->  "🃉"
     Ten -> case suit of
       Spades ->"🂪"
       Hearts -> "🂺"
       Clubs ->  "🃚"
       Diamonds -> "🃊"
     Jack -> case suit of
       Spades ->"🂫"
       Hearts -> "🂻"
       Clubs ->  "🃛"
       Diamonds -> "🃋"
     Queen -> case suit of
       Spades ->"🂭"
       Hearts -> "🂽"
       Clubs ->  "🃝"
       Diamonds -> "🃍"
     King -> case suit of
       Spades -> "🂮"
       Hearts -> "🂾"
       Clubs ->  "🃞"
       Diamonds -> "🃎"


{-
  Modify this function (if needed) to work with your `Card` definition
-}
viewCard : Card -> Html msg
viewCard card =
   let
     suit = case card of
            (Card _ Hearts) -> Hearts
            (Card _ Diamonds) -> Diamonds
            (Card _ Spades) -> Spades
            (Card _ Clubs) -> Clubs

     face = case card of
            (Card Two _) -> Two
            (Card Three _) -> Three
            (Card Four _) -> Four
            (Card Five _) -> Five
            (Card Six _) -> Six
            (Card Seven _) -> Seven
            (Card Eight _) -> Eight
            (Card Nine _) -> Nine
            (Card Ten _) -> Ten
            (Card King _) -> King
            (Card Queen _) -> Queen
            (Card Jack _) -> Jack
            (Card Ace _) -> Ace

     faceName = faceToString face
     suitName = suitToString suit
     suitColor s =
       case s of
         Diamonds -> "red"
         Spades -> "black"
         Hearts -> "red"
         Clubs -> "black"
     unicode = cardToUnicode card
   in
     div [style "display" "inline-block"] [
       div [style "font-size" "15em", style "color" (suitColor suit)] [text unicode],
       div [style "font-size" "0.8em"]  [text (cardToString card)]
     ]