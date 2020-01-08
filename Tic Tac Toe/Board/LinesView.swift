//
//  LinesView.swift
//  Tic Tac Toe
//
//  Created by Peter Janosky on 1/8/20.
//  Copyright © 2020 Peter Janosky. All rights reserved.
//

import SwiftUI

struct LinesView: View {
    var geometry: GeometryProxy
    let size: CGFloat
    let offset: CGFloat
    init(geometry: GeometryProxy) {
        self.geometry = geometry
        self.size = min(self.geometry.size.width, self.geometry.size.height)
        self.offset = size / 3
    }
    
    
    var body: some View {
        Path { path in
            for n in 1..<3 {
                path.move(to: CGPoint(x: 0, y: self.offset * CGFloat(n)))
                path.addLine(to: CGPoint(x: self.size, y: self.offset * CGFloat(n)))
                path.move(to: CGPoint(x: self.offset * CGFloat(n), y: 0))
                path.addLine(to: CGPoint(x: self.offset * CGFloat(n), y: self.size))
            }
        }.stroke(Color.black, lineWidth: 10)
    }
}

struct LinesView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            LinesView(geometry: geometry)
        }
    }
}
