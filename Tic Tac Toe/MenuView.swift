//
//  MenuView.swift
//  Tic Tac Toe
//
//  Created by Peter Janosky on 1/11/20.
//  Copyright © 2020 Peter Janosky. All rights reserved.
//

import SwiftUI

struct MenuView: View {
    @EnvironmentObject var data: Data
    @State var games = 3
    
    var body: some View {
        VStack {
            Text("Mode")
                .font(.headline)
                .padding(.top)
            Picker(selection: self.$data.gameBoard.expertMode, label: Text("Mode")) {
                Group {
                    Text("Regular").tag(false)
                    Text("Expert").tag(true)
                }
            }.pickerStyle(SegmentedPickerStyle())
            .font(.headline)
            
            Text("Players")
            .font(.headline)
            Picker(selection: self.$data.aiEnabled, label: Text("Mode")) {
                Text("Single Player").tag(true)
                Text("Multiplayer").tag(false)
            }.pickerStyle(SegmentedPickerStyle())
            
            Divider().padding(5)
                        
            self.tournamentSettings
            
            Divider().padding(5)
                        
            self.colorSelectors
            
            Spacer()
            
        }.padding(.horizontal)
    }
    
    var colorSelectors: some View {
        VStack {
            Text("Colors")
                .font(.headline)
            HStack {
                Text("X Color:")
                Spacer()
                ColorPicker(selectedColor: self.$data.colorX)
            }
            HStack {
                Text("O Color:")
                Spacer()
                ColorPicker(selectedColor: self.$data.colorO)
            }
        }
    }
    
    var tournamentSettings: some View {
        VStack {
            Text("Tournament")
                .font(.headline)
            Stepper("Number of Games: \(self.games)", value: self.$games, in: 2...100)
            Button(action: {self.data.startTournament(numberGames: self.games)}) {
                Text("Start Tournament")
            }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
            .frame(width: 360)
            .environmentObject(Data())
    }
}
