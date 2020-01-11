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
        ConfettiView()
            .alert(isPresented: self.$showAlert) {
                Alert(title: Text(self.alertText), dismissButton: .default(Text("OK"), action: {self.data.showConfetti = false}))
            }
    }
    
    var alertText: String {
        if self.data.tournamentWinner == nil {
            return "It's a Draw!"
        } else {
            return "\(self.data.tournamentWinner!.description) Won The Tournament!"
        }
    }
}

struct TournamentWinnerView_Previews: PreviewProvider {
    static var previews: some View {
        TournamentWinnerView()
        .environmentObject(Data())
    }
}
