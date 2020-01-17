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
                }.alert(isPresented: self.$showAlert) { self.alert }
                
                Spacer()
                Button(action: {self.showMenu.toggle()}) {
                    Text("Menu")
                }.popover(isPresented: self.$showMenu) {
                    MenuView(isPresented: self.$showMenu).environmentObject(self.data)
                }
            }.padding()
            .overlay(
                Text("Tic Tac Toe")
                    .font(.largeTitle)
            )
            
            BoardView().padding(20)
            
            InformationBar()
        }
    }
    
    func newGame() {
        if data.tournamentMode && self.data.gameNumber != self.data.totalGames {
            showAlert = true
        } else {
            self.data.tournamentMode = false
            data.resetBoard()
        }
    }
    var alert: Alert {
        Alert(
            title: Text("Are you sure you want to exit the current tournament?"),
            primaryButton: .default(Text("Exit"), action: {
                self.data.tournamentMode = false
                self.newGame()
            }),
            secondaryButton: .cancel()
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Data())
    }
}
