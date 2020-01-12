//
//  TournamentWinnerView.swift
//  Tic Tac Toe
//
//  Created by Peter Janosky on 1/9/20.
//  Copyright © 2020 Peter Janosky. All rights reserved.
//

import SwiftUI

struct TournamentWinnerView: View {
    @EnvironmentObject var data: Data
    @State var showAlert = true
    
    var body: some View {
        GeometryReader { geometry in
            if self.showAlert {
                ConfettiView(geometry: geometry)
                    .transition(.opacity)
                    .alert(isPresented: self.$showAlert) { self.alert }
            }
        }
    }
    
    var alert: Alert {
        Alert(
            title: Text(self.alertText),
            dismissButton: .default(Text("OK"), action: {
                withAnimation(.linear(duration: 0.25)) {
                    self.showAlert = false
                }
            })
        )
    }
    
    var alertText: String {
        if self.data.scores[.x] == self.data.scores[.o] {
            return "The Tournament Ended in a Draw"
        } else {
            let winner = self.data.scores.max(by: {$0.value < $1.value})!.key
            return "\(winner) Won The Tournament!"
        }
    }
}

struct TournamentWinnerView_Previews: PreviewProvider {
    static var previews: some View {
        TournamentWinnerView()
        .environmentObject(Data())
    }
}
