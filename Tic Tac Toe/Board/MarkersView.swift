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
    let offset: CGFloat
    
    init(geometry: GeometryProxy) {
        self.offset = min(geometry.size.width, geometry.size.height) / 3
    }

    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<3) { row in
                HStack(spacing: 0) {
                    ForEach(0..<3) { col in
                        if self.data.gameBoard[Coordinate(row, col)] == nil {
                            Spacer()
                                .frame(width: self.offset, height: self.offset)
                                .contentShape(Rectangle())
                                .onTapGesture{ self.data.makeMove(Coordinate(row, col)) }
                        } else {
                            MarkerImage(marker: self.data.gameBoard[Coordinate(row, col)]!)
                                .padding(self.offset / 6)
                                .frame(width: self.offset, height: self.offset)
                                .rotation3DEffect(
                                    self.data.winner != nil && self.data.winningCoordinates!.contains(Coordinate(row, col)) ? .degrees(180) : .degrees(0),
                                    axis: (x: 0, y: 1, z: 0)
                                )
                        }
                    }
                }
            }
        }.disabled(self.data.gameOver)
    }
}

struct MarkersView_Previews: PreviewProvider {    
    static var previews: some View {
        GeometryReader {geometry in
            MarkersView(geometry: geometry)
        }
    }
}
