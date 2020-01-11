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
    @State var showNewGame = false
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Button(action: {
                    self.showNewGame.toggle()
                }) {
                    Text("New Game")
                }.frame(width: 100, alignment: .leading)
                .popover(isPresented: self.$showNewGame) {
                    NewGameView(isPresented: self.$showNewGame)
                        .environmentObject(self.data)
                }
                
                Spacer()
                
                Text(self.data.mode)
                    .font(.title)
                
                Spacer()
                
                Button(action: {self.showSettings.toggle()}) {
                    Text("Settings")
                }.frame(width: 100, alignment: .trailing)
                .popover(isPresented: self.$showSettings) {
                    SettingsView()
                        .environmentObject(self.data)
                }
            }.padding()
            
            BoardView()
                .padding(20)
            
            InformationBar()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Data())
    }
}
