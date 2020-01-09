//
//  ContentView.swift
//  Tic Tac Toe
//
//  Created by Peter Janosky on 1/5/20.
//  Copyright © 2020 Peter Janosky. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var gameBoard = GameBoard(firstMarker: .x)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
