//
//  InformationBar.swift
//  Tic Tac Toe
//
//  Created by Peter Janosky on 1/9/20.
//  Copyright © 2020 Peter Janosky. All rights reserved.
//

import SwiftUI

struct InformationBar: View {
    @EnvironmentObject var data: Data
    
    var body: some View {
        ZStack {
            if self.data.tournamentMode {
                HStack {
                    ScoreBoard()
                    Spacer()
                    if self.data.gameOver && self.data.gameNumber < self.data.totalGames {
                        Button(action: {
                            self.data.resetBoard()
                            self.data.gameNumber += 1
                        }) {
                            HStack {
                                Text("Next Game").frame(width: 50)
                                Image(systemName: "chevron.right")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 20)
                            }
                        }
                    }
                }.padding()
            }
            
            StatusText()
        }.frame(minHeight: 100)
        .transition(.identity)
    }
}

struct InformationBar_Previews: PreviewProvider {
    static let data = Data()
    
    static var previews: some View {
        InformationBar()
            .environmentObject(data)
            .onAppear{
                data.tournamentMode = true
                data.gameOver = true
        }
    }
}
