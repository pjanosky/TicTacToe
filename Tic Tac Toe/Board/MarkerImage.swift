//
//  MarkerView.swift
//  Tic Tac Toe
//
//  Created by Peter Janosky on 1/8/20.
//  Copyright © 2020 Peter Janosky. All rights reserved.
//

import SwiftUI

struct MarkerImage: View {
    @EnvironmentObject var data: Data
    var marker: Marker
    
    var body: some View {
        Group {
            if self.marker == .x {
                Image(systemName: "xmark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .font(.system(size: 1, weight: .bold, design: .default))
                    .foregroundColor(self.data.colorX)
            } else {
                Image(systemName: "circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .font(.system(size: 1, weight: .black, design: .default))
                    .foregroundColor(self.data.colorO)
            }
        }
    }
}

struct MarkerImage_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            MarkerImage(marker: .x).environmentObject(Data())
            MarkerImage(marker: .o).environmentObject(Data())
        }
    }
}
