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
    @State var showMenu = false
    @State var showAlert = false
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Button(action: self.newGame) {
                    Text("New Game")
                }.frame(width: 100, alignment: .leading)
                
                Spacer()
                
                Text(self.title)
                    .font(.title)
                
                Spacer()
                
                Button(action: {self.showMenu.toggle()}) {
                    Text("Menu")
                }.frame(width: 100, alignment: .trailing)
                .popover(isPresented: self.$showMenu) {
                    MenuView(isPresented: self.$showMenu).environmentObject(self.data)
                }
            }.padding()
            
            BoardView().padding(20)
            
            InformationBar()
        }.alert(isPresented: self.$showAlert) {
            Alert(
                title: Text("Are you sure you want to exit the tournament?"),
                primaryButton: .default(Text("Exit"), action: {
                    self.data.tournamentMode = false
                    self.newGame()
                }),
                secondaryButton: .cancel()
            )
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
    
    func newGame() {
        if data.tournamentMode {
            showAlert = true
        } else {
            data.resetBoard()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Data())
    }
}
