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
        HStack {
            Group {
                if self.data.tournamentMode {
                    ScoreBoard()
                } else {
                    Spacer()
                }
            }.frame(width: 150, alignment: .leading)
            
            Spacer()
            Group {
                if self.data.winner != nil {
                    Text("\(self.data.winner!.description) Won!")
                        .bold()
                } else if self.data.gameOver {
                    Text("It's a Draw")
                        .bold()
                } else {
                    Text("\(self.data.gameBoard.current.description)'s Turn")
                        .bold()
                        .foregroundColor(self.data.gameBoard.current == .x ? self.data.xColor : self.data.oColor)
                }
            }.font(.largeTitle)
            Spacer()
            
            Group {
                if self.data.tournamentMode && self.data.gameOver && self.data.gameNumber < self.data.totalGames {
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
                } else {
                    Spacer()
                }
            }.frame(width: 150, alignment: .trailing)
        }.padding()
            .frame(minHeight: 100)
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
