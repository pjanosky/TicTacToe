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
    private (set) var turn = 1
    private (set) var currentMarker = Marker.random
    
    var expertMode = false
    
    private var lastMove = Coordinate(-1, -1)
    private var offense = false
        
    private let winningCombinations = [
        [Coordinate(0, 0), Coordinate(0, 1), Coordinate(0, 2)],
        [Coordinate(1, 0), Coordinate(1, 1), Coordinate(1, 2)],
        [Coordinate(2, 0), Coordinate(2, 1), Coordinate(2, 2)],
        [Coordinate(0, 0), Coordinate(1, 0), Coordinate(2, 0)],
        [Coordinate(0, 1), Coordinate(1, 1), Coordinate(2, 1)],
        [Coordinate(0, 2), Coordinate(1, 2), Coordinate(2, 2)],
        [Coordinate(0, 0), Coordinate(1, 1), Coordinate(2, 2)],
        [Coordinate(0, 2), Coordinate(1, 1), Coordinate(2, 0)]
    ]
    
    private let orthogonalCombinations: [[Coordinate]] = [
        [Coordinate(0, 0), Coordinate(0, 1), Coordinate(0, 2)],
        [Coordinate(1, 0), Coordinate(1, 1), Coordinate(1, 2)],
        [Coordinate(2, 0), Coordinate(2, 1), Coordinate(2, 2)],
        [Coordinate(0, 0), Coordinate(1, 0), Coordinate(2, 0)],
        [Coordinate(0, 1), Coordinate(1, 1), Coordinate(2, 1)],
        [Coordinate(0, 2), Coordinate(1, 2), Coordinate(2, 2)]
    ]
    
    private let corners: [Coordinate] = [
        Coordinate(0, 0),
        Coordinate(2, 0),
        Coordinate(0, 2),
        Coordinate(2, 2)
    ]
    
    subscript(_ c: Coordinate) -> Marker? {
        get {
            board[c.row][c.col]
        }
    }
    
    mutating func reset() {
        board = [[Marker?]](repeating: [Marker?](repeating: nil, count: 3), count: 3)
        turn = 1
        currentMarker = Marker.random
        lastMove = Coordinate(-1, -1)
        offense = false
    }
    
    func isValidSpace(_ c: Coordinate) -> Bool {
        return c.row >= 0 && c.row <= 2 && c.col >= 0 && c.col <= 2
    }
    
    func isEmptySpace(_ c: Coordinate) -> Bool {
        return self[c] == nil
    }
    
    var emptySpaces: [Coordinate] {
        var emptySpaces = [Coordinate]()
        for r in 0..<3 {
            for c in 0..<3 {
                if self[Coordinate(r, c)] == nil {
                    emptySpaces.append(Coordinate(r, c))
                }
            }
        }
        return emptySpaces
    }
    
    mutating func makeMove(_ c: Coordinate) {
        if expertMode && Int.random(in: 0...9) <= 2 {
            makeRandomMove(otherThan: c)
        } else {
            applyMove(c)
        }
    }
    
    mutating func makeRandomMove(otherThan c: Coordinate? = nil) {
        var spaces = emptySpaces
        spaces.removeAll(where: {$0 == c})
        if let move = spaces.randomElement() {
            applyMove(move)
        } else if let move = emptySpaces.first {
            applyMove(move)
        }
    }
    
    private mutating func applyMove(_ c: Coordinate) {
        if isEmptySpace(c) {
            board[c.row][c.col] = currentMarker
            turn += 1
            lastMove = c
            currentMarker = currentMarker.opposite
        } else {
            print("ERROR: invalid space")
        }
    }
    
    func checkForWinner() -> (winner: Marker, coordinates: [Coordinate])? {
        for coordinates in winningCombinations {
            if let space1 = self[coordinates[0]],
                let space2 = self[coordinates[1]],
                let space3 = self[coordinates[2]],
                space1 == space2,
                space1 == space3 {
                    return (space1, coordinates)
            }
        }
        return nil
    }
    
    var description: String {
        var s = ""
        for r in 0..<3 {
            for c in 0..<3 {
                s += board[r][c]?.description ?? "_" + " "
            }
            s += "\n"
        }
        return s
    }
}


extension GameBoard {
    mutating func aiMove() {
        //Check for game-ending move
        if let winningMove = checkForWinningMove(forMarker: currentMarker) {
            //Win if possible
            return makeMove(winningMove)
        } else if let opponentWinningMove = checkForWinningMove(forMarker: currentMarker.opposite) {
            //Block opponent
            return makeMove(opponentWinningMove)
        }
        
        //Starting strategy
        if turn == 1 {
            offense = true
            return makeMove(Coordinate(0, 0))
        } else if turn == 2 {
            if isEmptySpace(Coordinate(1, 1)) {
                return makeMove(Coordinate(1, 1))
            } else {
                return makeMove(emptyCorners.randomElement()!)
            }
        }
        
        //Endgame strategy
        if offense {
            makeOffensiveMove()
        } else {
            makeDefensiveMove()
        }
    }

    private mutating func makeOffensiveMove() {
        if turn == 3 {
            //Try to take middle (results in win)
            if isEmptySpace(Coordinate(1, 1)) {
                makeMove(Coordinate(1, 1))
            } else {
                //Otherwise resort to defensive strategy
                offense = false
                makeDefensiveMove()
            }
        } else if turn == 5 {
            //Set up fork to win next turn
            makeMove(getBestAdjacentMove(to: Coordinate(1, 1))!)
        } else if turn == 7 {
            //fork has failed, resort to defensive strategy
            offense = false
            makeDefensiveMove()
        } else {
            fatalError("Method should never be called on turns other than 3, 5, and 7")
        }
    }

    private mutating func makeDefensiveMove() {
        if let move = getBestAdjacentMove(to: lastMove) {
            //make best adjacent move (should all prevent forks?)
            makeMove(move)
        } else if let move = emptyCorners.randomElement() {
            //Otherwise make a random corner move
            makeMove(move)
        } else {
            //If all else fails, move randomly
            makeRandomMove()
        }
    }
    
    private var emptyCorners: [Coordinate] {
        return corners.filter{isEmptySpace($0)}
    }

    private func getBestAdjacentMove(to c: Coordinate) -> Coordinate? {
        //Find an adjacent space that would result in 2 in a row
        let adjacentSpaces = getAdjacentSpaces(to: c).filter{ isEmptySpace($0) }
        for adjacent in adjacentSpaces {
            for combo in orthogonalCombinations where combo.contains(adjacent) {
                let markers = combo.map{ self[$0] }
                if markers.contains(currentMarker) && !markers.contains(currentMarker.opposite) {
                    return adjacent
                }
            }
        }
        
        //Otherwise try to chose a adjacent space in the corner
        let cornerSpaces = emptyCorners
        let cornerAdjacentSpaces = adjacentSpaces.filter{cornerSpaces.contains($0)}
        if let move = cornerAdjacentSpaces.randomElement() {
            return move
        }
        return nil
    }
    
    private func getAdjacentSpaces(to c: Coordinate) -> [Coordinate] {
        let adjacentSpaces = [
            Coordinate(c.row - 1, c.col),
            Coordinate(c.row + 1, c.col),
            Coordinate(c.row, c.col - 1),
            Coordinate(c.row, c.col + 1)
        ]
        return adjacentSpaces.filter{isValidSpace($0)}
    }
    
    private func checkForWinningMove(forMarker markerToCheck: Marker) -> Coordinate? {
        for combo in winningCombinations {
            var count = 0
            var empty = Coordinate(0, 0)

            for coordinate in combo {
                if let marker = self[coordinate], marker == markerToCheck {
                    count += 1
                } else {
                    empty = coordinate
                }
            }

            if count == 2 && isEmptySpace(empty) {
                return empty
            }
        }
        return nil
    }
}
