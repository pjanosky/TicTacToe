//
//  GameBoard.swift
//  Tic Tac Toe
//
//  Created by Peter Janosky on 1/6/20.
//  Copyright © 2020 Peter Janosky. All rights reserved.
//

import Foundation
import SwiftUI

struct GameBoard: CustomStringConvertible {
    private var board = [[Marker?]](repeating: [Marker?](repeating: nil, count: 3), count: 3)
    private (set) var turn = 0
    private(set) var current = Marker.random
    var lastMove = Coordinate(0, 0)
    var attack = false
    
    private let winningCombinations: [[Coordinate]] = [
        [Coordinate(0, 0), Coordinate(0, 1), Coordinate(0, 2)],
        [Coordinate(1, 0), Coordinate(1, 1), Coordinate(1, 2)],
        [Coordinate(2, 0), Coordinate(2, 1), Coordinate(2, 2)],
        [Coordinate(0, 0), Coordinate(1, 0), Coordinate(2, 0)],
        [Coordinate(0, 1), Coordinate(1, 1), Coordinate(2, 1)],
        [Coordinate(0, 2), Coordinate(1, 2), Coordinate(2, 2)],
        [Coordinate(0, 0), Coordinate(1, 1), Coordinate(2, 2)],
        [Coordinate(0, 2), Coordinate(1, 1), Coordinate(2, 0)]
    ]
    
    mutating func makeMove(_ coordinate: Coordinate) {
        if board[coordinate.row][coordinate.col] == nil {
            board[coordinate.row][coordinate.col] = current
            turn += 1
            current = current.opposite
            lastMove = coordinate
        } else {
            print("error: space taken")
            return
        }
    }
    
    mutating func makeRandomMove() {
        if let randomMove = emptySpaces.randomElement() {
            makeMove(randomMove)
        }
    }
    
    var emptySpaces: [Coordinate] {
        var emptySpaces = [Coordinate]()
        for r in 0..<3 {
            for c in 0..<3 {
                if board[r][c] == nil {
                    emptySpaces.append(Coordinate(r, c))
                }
            }
        }
        return emptySpaces
    }
    
    func checkSpace(_ coordinate: Coordinate) -> Marker? {
        return board[coordinate.row][coordinate.col]
    }
    
    func spaceIsEmpty(_ coordinate: Coordinate) -> Bool {
        return board[coordinate.row][coordinate.col] == nil
    }
    
    func checkForWinner() -> (winner: Marker, coordinates: [Coordinate])? {
        for combo in winningCombinations {
            if let space1 = board[combo[0].row][combo[0].col],
                let space2 = board[combo[1].row][combo[1].col],
                let space3 = board[combo[2].row][combo[2].col],
                space1 == space2 && space1 == space3 {
                    return (space1, combo)
            }
        }
        return nil
    }
    
    var description: String {
        var s = ""
        for r in 0..<3 {
            for c in 0..<3 {
                if let marker = board[r][c] {
                    s += (marker == .x) ? "X " : "O "
                } else {
                    s += "_ "
                }
            }
            s += "\n"
        }
        return s
    }
}


extension GameBoard {
    mutating func aiMove() {
        // Two Modoes: Attack (try to set trap), and Defense (block unless can win)
        //  - Check for ability to win and blocking opponent winning at the beginning of every turn
        //
        // 1. AI Goes Girst:
        //      - Attack mode; place first marker in corner
        //      - If opponent moves anywhere other than center, continue to victory
        //      - If opponent moves in center, switch to defense
        //
        // 2. Opponent Goes First
        //      - play in center first if possible, else a random first move
        //      - continue in defense mode


        //Check for game over move
        if let winningMove = checkForWinningMove(forMarker: current) {
            return makeMove(winningMove)
        } else if let opponentWinningMove = checkForWinningMove(forMarker: current.opposite) {
            return makeMove(opponentWinningMove)
        }

        if turn == 0 {
            attack = true
            return makeMove(Coordinate(0, 0))
        }

        if attack {
            offensiveMove()
        } else {
            defensiveMove()
        }
    }

    mutating func offensiveMove() {
        if turn == 2 {
            //Try to take middle (results in win)
            if spaceIsEmpty(Coordinate(1, 1)) {
                return makeMove(Coordinate(1, 1))
            } else {
                //Otherwise resort to defensive stratege
                attack = false
                return defensiveMove()
            }
        } else if turn == 4 {
            //Set up fork to win next turn
            return makeMove(getBestAdjacentMove())
        }
        fatalError("This method should not be called on turns other than 2 and 4")
    }

    func getBestAdjacentMove() -> Coordinate {
        fatalError("Needs implementation")
    }

    mutating func defensiveMove() {
        //Try to take middle
        if spaceIsEmpty(Coordinate(1, 1)) {
            return makeMove(Coordinate(1, 1))
        }

        //Make sure opponent is not setting up a fork
        if let forkPreventingMove = getForkPreventingMove() {
            return makeMove(forkPreventingMove)
        }

        //Otherwise move randomly
        makeRandomMove()
    }

    func getForkPreventingMove() -> Coordinate? {
        fatalError("need implementation")
    }

    func checkForWinningMove(forMarker markerToCheck: Marker) -> Coordinate? {
        for combo in winningCombinations {
            var count = 0
            var empty = Coordinate(0, 0)

            for coordinate in combo {
                if let marker = board[coordinate.row][coordinate.col], marker == markerToCheck {
                    count += 1
                } else {
                    empty = coordinate
                }
            }

            if count == 2 {
                return empty
            }
        }
        return nil
    }
}
