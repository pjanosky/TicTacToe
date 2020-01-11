//
//  ColorPicker.swift
//  Tic Tac Toe
//
//  Created by Peter Janosky on 1/9/20.
//  Copyright © 2020 Peter Janosky. All rights reserved.
//

import SwiftUI

struct ColorPicker: View {
    @Binding var selectedColor: Color
    var colors = [Color("red_color"), Color("blue_color"), Color("green_color"), Color("purple_color"), Color("pink_color"), Color("peach_color"), Color("black_color")]
    
    var body: some View {
        HStack(spacing: 2) {
            ForEach(self.colors, id: \.description) {color in
                Button(action: {self.selectedColor = color}) {
                    Circle().frame(width: 30, height: 30)
                        .foregroundColor(color)
                        .padding(5)
                        .overlay(
                            Circle().stroke(Color.secondary, lineWidth: self.selectedColor == color ? 5 : 0)
                        )
                }
            }
        }
    }
}

struct ColorPicker_Previews: PreviewProvider {
    @State static var color = Color.white
    static var previews: some View {
        ColorPicker(selectedColor: $color)
    }
}
