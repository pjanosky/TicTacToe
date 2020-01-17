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
    @Binding var isPresented: Bool
    @State var games = 3
    
    var body: some View {
        VStack {
            self.options
            Divider().padding()
            self.tournamentSettings
            Divider().padding()
            self.colorPickers
            Spacer()
        }.padding(.horizontal)
    }
    
    var options: some View {
        Group {
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
        }
    }
    
    var colorPickers: some View {
        Group {
            Text("Colors")
                .font(.headline)
            HStack {
                Text("X:")
                Spacer()
                ColorPicker(selectedColor: self.$data.colorX)
            }
            HStack {
                Text("O:")
                Spacer()
                ColorPicker(selectedColor: self.$data.colorO)
            }
        }
    }
    
    var tournamentSettings: some View {
        Group {
            Text("Tournament")
                .font(.headline)
            Stepper("Number of Games: \(self.games)", value: self.$games, in: 2...100)
            Button(action: {
                self.data.startTournament(numberGames: self.games)
                self.isPresented = false
            }) {
                Text("Start Tournament")
            }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    @State static var isPresented = true
    static var previews: some View {
        MenuView(isPresented: $isPresented)
            .frame(width: 320)
            .environmentObject(Data())
    }
}
