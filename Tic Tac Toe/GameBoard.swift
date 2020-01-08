//
//  GameBoard.swift
//  Tic Tac Toe
//
//  Created by Peter Janosky on 1/6/20.
//  Copyright © 2020 Peter Janosky. All rights reserved.
//

import Foundation

struct GameBoard: CustomStringConvertible {
    private var board = [[Marker?]](repeating: [Marker?](repeating: nil, count: 3), count: 3)
    private (set) var turn = 0
    private(set) var current: Marker
    
    init(firstMarker: Marker) {
        self.current = firstMarker
    }
    
    private let winningCombinations: [[Coordinate]] = [
        [(0, 0), (0, 1), (0, 2)],
        [(1, 0), (1, 1), (1, 2)],
        [(2, 0), (2, 1), (2, 2)],
        [(0, 0), (1, 0), (2, 0)],
        [(0, 1), (1, 1), (2, 1)],
        [(0, 2), (1, 2), (2, 2)],
        [(0, 0), (1, 1), (2, 2)],
        [(0, 2), (1, 1), (2, 0)]
    ]
    
    mutating func move(_ coor: Coordinate) {
        if board[coor.row][coor.col] == nil {
            board[coor.row][coor.col] = current
        } else {
            print("error: space taken")
            return
        }
        
        turn += 1
        current = current.opposite
    }
    
    mutating func moveRandom() {
        if let randomMove = getEmptySpaces().randomElement() {
            move(randomMove)
        }
    }
    
    func getEmptySpaces() -> [Coordinate] {
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
    
    func checkSpace(_ coor: Coordinate) -> Marker? {
        return board[coor.row][coor.col]
    }
    
    func spaceIsEmpty(_ coor: Coordinate) -> Bool {
        return board[coor.row][coor.col] == nil
    }
    
    func checkForWinner() -> (marker: Marker, winningCombination: [Coordinate])? {
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


//extension GameBoard {
//    mutating func aiMove() {
//        // Two Modoes: Attack (try to set trap), and Defense (block unless can win)
//        //  - Check for ability to win and blocking opponent winning at the beginning of every turn
//        //
//        // 1. AI Goes Girst:
//        //      - Attack mode; place first marker in corner
//        //      - If opponent moves anywhere other than center, continue to victory
//        //      - If opponent moves in center, switch to defense
//        //
//        // 2. Opponent Goes First
//        //      - play in center first if possible, else a random first move
//        //      - continue in defense mode
//
//
//        //Check for game over move
//        if let winningMove = checkForWinningMove(forMarker: current) {
//            return move(winningMove)
//        } else if let opponentWinningMove = checkForWinningMove(forMarker: current.opposite) {
//            return move(opponentWinningMove)
//        }
//
//        if turn == 0 {
//            attack = true
//            return move(Coordinate(0, 0))
//        }
//
//        if attack {
//            offensiveMove()
//        } else {
//            defensiveMove()
//        }
//    }
//
//    mutating func offensiveMove() {
//        if turn == 2 {
//            //Try to take middle (results in win)
//            if spaceIsEmpty(Coordinate(1, 1)) {
//                return move(Coordinate(1, 1))
//            } else {
//                //Otherwise resort to defensive stratege
//                attack = false
//                return defensiveMove()
//            }
//        } else if turn == 4 {
//            //Set up fork to win next turn
//            return move(getForkMove())
//        }
//        fatalError("This method should not be called on turns other than 2 and 4")
//    }
//
//    func getForkMove() -> Coordinate {
//        fatalError("Needs implementation")
//    }
//
//    mutating func defensiveMove() {
//        //Try to take middle
//        if spaceIsEmpty(Coordinate(1, 1)) {
//            return move(Coordinate(1, 1))
//        }
//
//        //Make sure opponent is not setting up a fork
//        if let forkPreventingMove = getForkPreventingMove() {
//            return move(forkPreventingMove)
//        }
//
//        //Otherwise move randomly
//        moveRandom()
//    }
//
//    func getForkPreventingMove() -> Coordinate? {
//        fatalError("need implementation")
//    }
//
//    func checkForWinningMove(forMarker markerToCheck: Marker) -> Coordinate? {
//        for combo in winningCombinations {
//            var count = 0
//            var empty = (0, 0)
//
//            for coordinate in combo {
//                if let marker = board[coordinate.row][coordinate.col], marker == markerToCheck {
//                    count += 1
//                } else {
//                    empty = coordinate
//                }
//            }
//
//            if count == 2 {
//                return empty
//            }
//        }
//        return nil
//    }
//}

enum Marker {
    case x, o
    var opposite: Marker {
        if self == .x {
            return .o
        } else {
            return .x
        }
    }
}

typealias Coordinate = (row: Int, col: Int)
