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
        ZStack(alignment: .topLeading) {
            ForEach(0..<3) { row in
                ForEach(0..<3) { col in
                    Group {
                        if self.gameBoard.checkSpace(Coordinate(row, col)) == nil {
                            Spacer()
                                .contentShape(Rectangle())
                                .onTapGesture{
                                    print("moving (\(row), \(col))")

                                    withAnimation(.spring()) {
                                        self.gameBoard.move(Coordinate(row, col))
                                    }
                                }
                        } else {
                            MarkerView(marker: self.gameBoard.checkSpace(Coordinate(row, col))!)
                                .transition(.scale(scale: 0.0, anchor: .center))
                                
                        }
                    }
                    .frame(width: self.size, height: self.size)
                    .offset(CGSize(width: self.size * CGFloat(col), height: self.size * CGFloat(row)))
                }
            }
        }
    }
}
