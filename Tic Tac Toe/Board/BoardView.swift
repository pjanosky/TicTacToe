//
//  BoardView.swift
//  Tic Tac Toe
//
//  Created by Peter Janosky on 1/7/20.
//  Copyright © 2020 Peter Janosky. All rights reserved.
//

import SwiftUI

struct BoardView: View {
    @Binding var gameBoard: GameBoard
    var size: CGFloat = 0
    var offset: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
                LinesView(geometry: geometry)
                MarkersGrid(gameBoard: self.$gameBoard, geometry: geometry)
            }
        }
    }
}

struct BoardView_Previews: PreviewProvider {
    @State static var gameBoard: GameBoard = GameBoard(firstMarker: .x)
    
    static var previews: some View {
        DummyView()
    }
}

struct DummyView: View {
    @State var gameBoard: GameBoard = GameBoard(firstMarker: .x)
    init() {
        var gb = GameBoard(firstMarker: .x)
        gb.move(Coordinate(1, 1))
        gb.move(Coordinate(2, 0))
        self.gameBoard = gb
    }
    
    var body: some View {
        BoardView(gameBoard: self.$gameBoard)
            .padding()
    }
}
