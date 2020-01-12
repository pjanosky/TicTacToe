//
//  BoardView.swift
//  Tic Tac Toe
//
//  Created by Peter Janosky on 1/7/20.
//  Copyright © 2020 Peter Janosky. All rights reserved.
//

import SwiftUI

struct BoardView: View {
    @EnvironmentObject var data: Data
    
    var body: some View {
        GeometryReader {geometry in
            ZStack {
                LinesView(geometry: geometry)
                MarkersView(geometry: geometry)
                
                if self.data.tournamentMode && self.data.gameNumber == self.data.totalGames && self.data.gameOver {
                    TournamentWinnerView()
                }
            }
        }
    }
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            BoardView()
            .environmentObject(Data())
        }
    }
}
