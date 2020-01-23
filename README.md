# Matching cards game

Building a game similar to [this](https://www.youtube.com/watch?v=4J1NljuLS0I)

## Rules

 Player sees a square board with cards on it
 He swaps first card
 Swaps second card
 If both cards match they remain visible
 player gets 100 points

 If cards do not match they swap again and remain hidden

 in both cases the number of tries decreases

 The game ends when the player uses all the available tries or all cards are shown

 When the game ends it shows the number of points obtained by the player


## Modeling state

 ```
 Gameplay -has_one-> Board

 Board
   elements: { Position => Card }
   number_of_cards (an even number)
   number_of_columns
   number_of_rows

   restrictions:
     number_of_cards = columns * rows
     every type of card must be repeated only once

 Position
   x
   y

 Card
   type
   image

 cards are comparable by its type
 ```


