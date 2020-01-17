//
//  StatusText.swift
//  Tic Tac Toe
//
//  Created by Peter Janosky on 1/14/20.
//  Copyright © 2020 Peter Janosky. All rights reserved.
//

import SwiftUI

struct StatusText: View {
    @EnvironmentObject var data: Data
    
    var body: some View {
        VStack {
            if self.data.winner != nil {
                if self.data.aiEnabled {
                    if self.data.winner! == self.data.aiMarker {
                        Text("You Lost!")
                        .bold()
                    } else {
                        Text("You Won!")
                        .bold()
                    }
                } else {
                    Text("\(self.data.winner!.description) Won!")
                        .foregroundColor(self.data.color(forMarker: self.data.winner!))
                        .bold()
                }
            } else if self.data.gameOver {
                Text("It's a Draw")
                    .bold()
            } else if self.data.aiEnabled {
                Text("Your Turn")
                    .foregroundColor(self.data.color(forMarker: self.data.aiMarker.opposite))
                    .bold()
            } else {
                Text("\(self.data.gameBoard.currentMarker.description)'s Turn")
                    .foregroundColor(self.data.color(forMarker: self.data.gameBoard.currentMarker))
                    .bold()
            }
        }.font(.largeTitle)
    }
}

struct StatusText_Previews: PreviewProvider {
    static var previews: some View {
        StatusText().environmentObject(Data())
    }
}
