//
//  ContentView.swift
//  Tic Tac Toe
//
//  Created by Peter Janosky on 1/5/20.
//  Copyright © 2020 Peter Janosky. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var data: Data
    @State var showSettings = false
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Button(action: {
                    self.data.resetBoard()
                }) {
                    Text("New Game")
                }.frame(width: 100, alignment: .leading)
                
                Spacer()
                
                Text(self.title)
                    .font(.title)
                
                Spacer()
                
                Button(action: {self.showSettings.toggle()}) {
                    Text("Menu")
                }.frame(width: 100, alignment: .trailing)
                .popover(isPresented: self.$showSettings) {
                    MenuView().environmentObject(self.data)
                }
            }.padding()
            
            BoardView().padding(20)
            
            InformationBar()
        }
    }
    
    var title: String {
        if data.tournamentMode {
            return "Tournament"
        } else if data.aiEnabled {
            return "Single Player"
        } else {
            return "Multiplayer"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Data())
    }
}
