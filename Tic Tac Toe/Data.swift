//
//  Data.swift
//  Tic Tac Toe
//
//  Created by Peter Janosky on 1/8/20.
//  Copyright © 2020 Peter Janosky. All rights reserved.
//

import Foundation
import SwiftUI

class Data: ObservableObject {
    @Published var gameBoard = GameBoard()
    @Published var expertMode = false
    @Published var aiEnabled = false
    
    @Published var gameOver = false
    @Published var winner: Marker?
    @Published var winningCoordinates: [Coordinate]?
    
    @Published var xColor = Color("red_color")
    @Published var oColor = Color("blue_color")
    
    @Published var tournamentMode = false
    @Published var totalGames = 3
    @Published var gameNumber = 1
    @Published var scores = [Marker.x: 0, Marker.o: 0]
    @Published var showConfetti = false
    
    func checkForWinner() {
        if let (winner, coordinates) = self.gameBoard.checkForWinner() {
            winnerFound(winner: winner, coordinates: coordinates)
        } else if gameBoard.turn == 9 {
            gameOver = true
        } else {
            gameOver = false
            winner = nil
            winningCoordinates = nil
        }
    }
    
    private func winnerFound(winner: Marker, coordinates: [Coordinate]) {
        self.gameOver = true
        self.winner = winner
        self.winningCoordinates = coordinates
        
        if tournamentMode {
            scores[winner]! = scores[winner]! + 1
        }
    }
    
    func resetBoard() {
        gameOver = false
        winner = nil
        winningCoordinates = nil
        gameBoard = GameBoard()
    }
    
    func resetTournament() {
        gameNumber = 1
        scores = [Marker.x: 0, Marker.o: 0]
    }
    
    var mode: String {
        if tournamentMode {
            return "Tournament"
        } else if aiEnabled {
            return "Single Player"
        } else {
            return "Multiplayer"
        }
    }
    
    var tournamentWinner: Marker? {
        if scores[.x]! > scores[.o]! {
            return .x
        } else if scores[.o]! > scores[.x]! {
            return .o
        }
        return nil
    }
    
    var currentColor: Color {
        gameBoard.current == .x ? self.xColor : self.oColor
    }
}
