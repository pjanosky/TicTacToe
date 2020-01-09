//
//  MarkerView.swift
//  Tic Tac Toe
//
//  Created by Peter Janosky on 1/8/20.
//  Copyright © 2020 Peter Janosky. All rights reserved.
//

import SwiftUI

struct MarkerView: View {
    var marker: Marker
    
    var body: some View {
        Group {
            if self.marker == .x {
                Image(systemName: "xmark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .font(.system(size: 1, weight: .bold, design: .default))
                    .foregroundColor(.red)
            } else {
                Image(systemName: "circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .font(.system(size: 1, weight: .black, design: .default))
                    .foregroundColor(.blue)
            }
        }
    }
}

struct MarkerView_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            MarkerView(marker: .x)
            MarkerView(marker: .o)
        }
    }
}
