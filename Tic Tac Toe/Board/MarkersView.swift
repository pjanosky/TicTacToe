//
//  MarkersGrid.swift
//  Tic Tac Toe
//
//  Created by Peter Janosky on 1/8/20.
//  Copyright © 2020 Peter Janosky. All rights reserved.
//

import SwiftUI

struct MarkersView: View {
    @EnvironmentObject var data: Data
    let size: CGFloat
    let offset: CGFloat
    
    init(size: CGFloat) {
        self.size = size
        self.offset = size / 3
    }

    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<3) { row in
                HStack(spacing: 0) {
                    ForEach(0..<3) { col in
                        if self.data.gameBoard.checkSpace(Coordinate(row, col)) == nil {
                            Spacer()
                                .frame(width: self.offset, height: self.offset)
                                .contentShape(Rectangle())
                                .onTapGesture{ self.move(row: row, col: col) }
                        } else {
                            MarkerImage(marker: self.data.gameBoard.checkSpace(Coordinate(row, col))!)
                                .padding(self.offset / 6)
                                .frame(width: self.offset, height: self.offset)
                                .transition(.scale)
                                .rotation3DEffect(
                                    (self.data.winner != nil && self.data.winningCoordinates!.contains(Coordinate(row, col))) ? .degrees(180) : .degrees(0),
                                    axis: (x: 0, y: 1, z: 0)
                            )
                        }
                    }
                }
            }
        }.disabled(self.data.gameOver)
    }
    
    func move(row: Int, col: Int) {
        withAnimation(.spring(response: 0.35, dampingFraction: 0.5)) {
            if self.data.expertMode && Int.random(in: 0...9) <= 2 {
                self.data.gameBoard.makeRandomMove()
            } else {
                self.data.gameBoard.makeMove(Coordinate(row, col))
            }
        }
        withAnimation(.spring(response: 0.55, dampingFraction: 0.7)) {
            self.data.checkForWinner()
        }
    }
}

struct MarkersView_Previews: PreviewProvider {    
    static var previews: some View {
        GeometryReader {geometry in
            MarkersView(size: min(geometry.size.width, geometry.size.height))
                .environmentObject(Data())
        }
    }
}
