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
    @Published var aiEnabled = false {
        didSet {
            aiMarker = gameBoard.currentMarker.opposite
        }
    }
    @Published var aiMarker = Marker.random
    
    @Published var gameOver = false
    @Published var winner: Marker?
    @Published var winningCoordinates: [Coordinate]?
    
    @Published var tournamentMode = false
    @Published var totalGames = 3
    @Published var gameNumber = 1
    @Published var scores = [Marker.x: 0, Marker.o: 0]
    
    @Published var colorX = Color("red_color")
    @Published var colorO = Color("blue_color")
    
    func checkForWinner() {
        if let (winner, coordinates) = self.gameBoard.checkForWinner() {
            withAnimation(Animation.spring(response: 0.55, dampingFraction: 0.7).delay(aiEnabled ? 0.65 : 0.25)) {
                self.gameOver = true
                self.winner = winner
                self.winningCoordinates = coordinates
            }
            
            if tournamentMode {
                scores[winner]! = scores[winner]! + 1
            }
        } else if gameBoard.turn > 9 {
            gameOver = true
        }
    }
    
    func makeMove(_ c: Coordinate) {
        withAnimation(.spring(response: 0.35, dampingFraction: 0.5)) {
            gameBoard.makeMove(c)
        }
        checkForWinner()
            
        if aiEnabled && !gameOver && gameBoard.turn <= 9 {
            withAnimation(Animation.spring(response: 0.35, dampingFraction: 0.5).delay(0.4)) {
                gameBoard.aiMove()
            }
            checkForWinner()
        }
    }
    
    func resetBoard() {
        gameOver = false
        winner = nil
        winningCoordinates = nil
        withAnimation(.linear(duration: 0.15)) {
            gameBoard.reset()
        }
        if !tournamentMode {
            aiMarker = Marker.random
        }
        
        if aiEnabled && gameBoard.currentMarker == aiMarker {
            withAnimation(.spring(response: 0.35, dampingFraction: 0.5)) {
                gameBoard.aiMove()
            }
        }
    }
    
    func startTournament(numberGames: Int) {
        resetBoard()
        tournamentMode = true
        totalGames = numberGames
        gameNumber = 1
        aiMarker = Marker.random
        scores = [Marker.x: 0, Marker.o: 0]
    }
}
