# Set Game 

Assignment 3 of the [Stanford CS193p 2020 SwiftUI Course](https://cs193p.sites.stanford.edu/). Simple implementation of a single player version of the Game [Set](https://en.wikipedia.org/wiki/Set_(card_game)/).  Full Assignment Document can be found [here](https://cs193p.sites.stanford.edu/sites/g/files/sbiybj16636/files/media/file/assignment_3.pdf).

## Objective

The goal of this assignment is to give you an opportunity to create your first app completely from scratch by yourself. It is similar enough to the first two assignments that you should be able to find your bearings, but different enough to give you the full experience! 

## Required Tasks

- [x] Implement a game of solo (i.e. one player) Set. 
- [ ] When your game is run for the very first time, there should briefly be no cards showing, but as soon as it appears, it should immediately deal 12 cards by having them “fly in” from random off-screen locations. 
- [x] As the game play progresses, use all the real estate on the screen in an efficient manner. Cards should get smaller (or larger) as more (or fewer) appear on-screen at the same time, while always using as much space as is available and still being “nicely arranged”. Grid does all this and you are welcome to use it. All changes to locations and/or sizes of cards must be animated. 
- [x] Cards can have any aspect ratio you like, but they must all have the same aspect ratio at all times (no matter their size and no matter how many are on screen at the same time). In other words, cards can be appearing to the user to get larger and smaller as the game goes on, but the cards cannot be “stretching” into different aspect ratios as the game is played. 
- [ ] The symbols on cards should be proportional to the size of the card (i.e. large cards should have large symbols and smaller cards should have smaller symbols). 
- [x] Users must be able to select up to 3 cards by touching on them in an attempt to make a Set (i.e. 3 cards which match, per the rules of Set). It must be clearly visible to the user which cards have been selected so far.
  - [ ] TODO: implement animation to show selection of cards (wiggle)
- [x] After 3 cards have been selected, you must indicate whether those 3 cards are a match or mismatch. You can show this any way you want (colors, borders, backgrounds, animation, whatever). Anytime there are 3 cards currently selected, it must be clear to the user whether they are a match or not (and the cards involved in a non-matching trio must look different than the cards look when there are only 1 or 2 cards in the selection). 
  - [ ] TODO: bettter Colors / clearer indication
- [x] Support “deselection” by touching already-selected cards (but only if there are 1 or 2 cards (not 3) currently selected). 
- [x] When any card is touched on and there are already 3 matching Set cards selected, then …
  - [x] as per the rules of Set, replace those 3 matching Set cards with new ones from the deck
  - [ ] the matched cards should fly away (animated) to random locations off-screen
  - [ ] the replacement cards should fly in (animated) from other random off-screen locations (or from a “deck” view somewhere on screen, see Extra Credit)
  - [x] if the deck is empty then the space vacated by the matched cards (which cannot be replaced) should be made available to the remaining cards (i.e. they’ll likely get bigger)
  - [x] if the touched card was not part of the matching Set, then select that card 
- [x] When any card is touched and there are already 3 non-matching Set cards selected, deselect those 3 non-matching cards and select the touched-on card (whether or not it was part of the non-matching trio of cards). 
- [x] You will need to have a “Deal 3 More Cards” button (per the rules of Set). 
  - [x] when it is touched, replace the selected cards if the selected cards make a Set (with fly-in/fly-away as described above)
  - [x] or, if the selected cards do not make a Set (or if there are fewer than 3 cards selected, including none), fly in (i.e. animate the arrival of) 3 new cards to join the ones already on screen (and do not affect the selection)
  - [x] disable this button if the deck is empty 
- [x] You also must have a “New Game” button that starts a new game (i.e. back to 12 randomly chosen cards). Cards should fly in and out when this happens as well.
- [x] To make your life a bit easier, you can replace the “squiggle” appearance in the Set game with a rectangle.
  - [ ] TODO: Create better Squiggle appearance
- [x] You must author your own Shape struct to do the diamond.
- [x] Another life-easing change is that you can use a semi-transparent color to represent the “striped” shading. Be sure to pick a transparency level that is clearly distinguishable from “solid”.
- [x] You can use any 3 colors as long as they are clearly distinguishable from each other.
- [x] You must use an enum as a meaningful part of your solution.
- [ ] You must use a closure (i.e. a function as an argument) as a meaningful part of your solution. 
- [x] Your UI should work in portrait or landscape on any iOS device. This probably will not require any work on your part (that’s part of the power of SwiftUI), but be sure to experiment with running on different simulators in Xcode to be sure. 

## To-Do:

- [ ] Animate the Cards flying in and out
- [ ] start the game with 0 cards, let them fly in
- [ ] better visualization of selected cards, matching / not matching set
- [ ] 