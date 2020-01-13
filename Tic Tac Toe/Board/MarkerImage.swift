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
            Image(systemName: marker == .x ? "xmark" : "circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(self.marker == .x ? self.data.colorX : self.data.colorO)
                .font(.system(
                    size: 1,
                    weight: self.marker == .x ? .bold : .black,
                    design: .default))
                .transition(.scale)
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
