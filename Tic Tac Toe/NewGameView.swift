//
//  NewGameView.swift
//  Tic Tac Toe
//
//  Created by Peter Janosky on 1/9/20.
//  Copyright © 2020 Peter Janosky. All rights reserved.
//

import SwiftUI

struct NewGameView: View {
    @EnvironmentObject var data: Data
    @Binding var isPresented: Bool
    @State var aiEnabled = false
    @State var totalGames = 3
    
    var body: some View {
        VStack {
            Text("New Game")
                .font(.title)
            
            Picker(selection: self.$aiEnabled, label: Text("Mode")) {
                Text("Multiplayer").tag(false)
                Text("Single Player (AI)").tag(true)
            }.pickerStyle(SegmentedPickerStyle())
            
            Divider().padding()
            
            Button(action: {
                self.updataData()
                self.data.tournamentMode = false
            }) {
                Text("Start Single Game")
            }
            
            Divider()
                .padding()
            
            Stepper("Number of Games: \(self.totalGames)", value: self.$totalGames, in: 2...100)
            
            Button(action: {
                self.data.totalGames = self.totalGames
                self.data.tournamentMode = true
                self.data.showConfetti = true
                self.updataData()
            }) {
                Text("Start Tournament")
            }.padding()
            Divider()
            Spacer()
        }.padding()
    }
    
    func updataData() {
        self.data.aiEnabled = self.aiEnabled
        withAnimation(.easeIn(duration: 0.15)) {
            self.data.resetBoard()
        }
        self.isPresented = false
    }
}

struct NewGameView_Previews: PreviewProvider {
    @State static var isPresented = true
    static var previews: some View {
        VStack {
            Text("").popover(isPresented: $isPresented) {
                NewGameView(isPresented: $isPresented)
            }
            Spacer()
        }
    }
}
