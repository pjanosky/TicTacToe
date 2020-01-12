//
//  ScoreBoard.swift
//  Tic Tac Toe
//
//  Created by Peter Janosky on 1/9/20.
//  Copyright © 2020 Peter Janosky. All rights reserved.
//

import SwiftUI

struct ScoreBoard: View {
    @EnvironmentObject var data: Data
    var body: some View {
        VStack(alignment: .leading) {
            Text("Game \(self.data.gameNumber) of \(self.data.totalGames)")
                .font(.headline).padding(.bottom, -10)
            Divider()
            Text("X: \(self.data.scores[.x]!) Wins")
                .foregroundColor(self.data.colorX)
            Text("O: \(self.data.scores[.o]!) Wins")
                .foregroundColor(self.data.colorO)
        }.frame(width: 150)
    }
}

struct ScoreBoard_Previews: PreviewProvider {
    static var previews: some View {
        ScoreBoard().environmentObject(Data())
    }
}
