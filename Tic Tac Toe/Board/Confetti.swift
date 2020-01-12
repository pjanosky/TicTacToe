//
//  Confetti.swift
//  Tic Tac Toe
//
//  Created by Peter Janosky on 1/9/20.
//  Copyright © 2020 Peter Janosky. All rights reserved.
//

import SwiftUI
import UIKit

struct ConfettiView: UIViewRepresentable {
    let geometry: GeometryProxy
    
    func makeUIView(context: UIViewRepresentableContext<ConfettiView>) -> UIView {
        let leftEmitter = CAEmitterLayer()
        let view = UIView()
        leftEmitter.emitterShape = .line
        leftEmitter.position = CGPoint(x: self.geometry.size.width / 2, y: -150)
        leftEmitter.emitterSize = CGSize(width: self.geometry.size.width, height: 1)
        
        let images = [
            UIImage(named: "confetti_red")!,
            UIImage(named: "confetti_blue")!,
            UIImage(named: "confetti_pink")!,
            UIImage(named: "confetti_yellow")!
        ]
        var leftCells = [CAEmitterCell]()
        for image in images {
            let cell = CAEmitterCell()
            cell.contents = image.withTintColor(.red, renderingMode: .alwaysTemplate).cgImage
            cell.birthRate = 25
            cell.lifetime = 7
            cell.scale = 0.2
            cell.velocity = 400
            cell.velocityRange = 50
            cell.scaleRange = 0.05
            cell.spin = CGFloat.pi / 2
            cell.yAcceleration = 300
            cell.xAcceleration = -25
            cell.emissionLongitude = CGFloat.pi
            cell.emissionRange = CGFloat.pi / 6
            leftCells.append(cell)
        }
        leftEmitter.emitterCells = leftCells
        
        view.layer.addSublayer(leftEmitter)
        view.tintColor = .red
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<ConfettiView>) {
        
    }
}

struct Confetti_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            ConfettiView(geometry: geometry)
        }
    }
}
