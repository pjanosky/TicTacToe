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
            title: Text(self.alertTitle),
            message: Text(self.alertMessage),
            dismissButton: .default(Text("OK"), action: {
                withAnimation(.linear(duration: 0.25)) {
                    self.showAlert = false
                }
            })
        )
    }
    
    var alertTitle: String {
        if data.scores[.x]! == data.scores[.o]! {
            return "The Tournament Ended In A Draw"
        } else {
            let winner = data.scores.max(by: {$0.value < $1.value})!.key
            if data.aiEnabled {
                if data.aiMarker == winner {
                    return "You Lost the Tournament!"
                } else {
                    return "You Won The Tournament!"
                }
            } else {
                return "\(winner) Won The Tournament!"
            }
        }
    }
    
    var alertMessage: String {
        let winningScore = data.scores.max(by: {$0.value < $1.value})!.value
        let loosingScore = data.scores.min(by: {$0.value < $1.value})!.value
        return "Final score \(winningScore) - \(loosingScore)"
    }
}

struct TournamentWinnerView_Previews: PreviewProvider {
    static var previews: some View {
        TournamentWinnerView()
        .environmentObject(Data())
    }
}
