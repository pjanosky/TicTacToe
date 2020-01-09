//
//  MarkersGrid.swift
//  Tic Tac Toe
//
//  Created by Peter Janosky on 1/8/20.
//  Copyright © 2020 Peter Janosky. All rights reserved.
//

import SwiftUI

struct MarkersGrid: View {
    @Binding var gameBoard: GameBoard
    let size: CGFloat
    
    init(gameBoard: Binding<GameBoard>, geometry: GeometryProxy) {
        self.size = min(geometry.size.width, geometry.size.height) / 3
        _gameBoard = gameBoard
    }

    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<3) { row in
                HStack(spacing: 0) {
                    ForEach(0..<3) { col in
                        if self.gameBoard.checkSpace(Coordinate(row, col)) == nil {
                            Spacer()
                                .frame(width: self.size, height: self.size)
                                .contentShape(Rectangle())
                                .onTapGesture{
                                    withAnimation(.spring(response: 0.35, dampingFraction: 0.5)) {
                                        self.gameBoard.move(Coordinate(row, col))
                                    }
                            }
                        } else {
                            MarkerView(marker: self.gameBoard.checkSpace(Coordinate(row, col))!)
                                .padding(self.size / 6)
                                .frame(width: self.size, height: self.size)
                                .transition(.scale)
                                
                        }
                    }
                }
            }
        }
    }
}
