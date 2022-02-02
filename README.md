# Tic Tac Toe

A simple Tic Tac Toe game written primarily with the SwiftUI API.

## Features

This app has a simple interface. Users take turns tapping on spaces on the board to place alternating markers. The app detects when a user has one, and displays an animation to indicate this fact. A new game can be started by pressing the "New Game" Button in the top left corner. Pressing the "Menu" button reveals a small selection of game settings:

* Turning on "expert" mode creates a 1 in 3 chance that a random move will be made in place of your actual move
* Selecting single player will enable the logic based virtual opponent. This opponent is designed such that it will always force a tie at the very least. It will also attempt to set up "forks" if given to opportunity.
* Pressing "Start Tournament" will start a best of `n` style tournament.
* The colors of both players can be changed with the color selectors

## Design
This app employs a standard SwiftUI design, with views composed of other smaller views that update automatically based on a model. In this case, the model is the `Data` struct. Most of the game logic is implemented in the `GameBoard` struct.

## Purpose

This app was not indented to be maintained over a long period of time. Instead, its purpose was to explore the functionality, expressibility, and speed to development of SwiftUI, and evaluate the pros and cons of using it in production code. Additionally, this app was also used to investigate the compatibility bewteen SwiftUI and UIKit to determine if SwiftUI features could be implemented incrementally in a UIKit app.

## Screenshots
Main Interface
![](Screenshots/Screenshot1.png?raw=true "Main Interface")

Settings Menu in Tournament Mode
![](Screenshots/Screenshot2.png?raw=true "Settings Menu in Tournament Mode")
