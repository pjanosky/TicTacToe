//
//  SettingsView.swift
//  Tic Tac Toe
//
//  Created by Peter Janosky on 1/8/20.
//  Copyright © 2020 Peter Janosky. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var data: Data
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Settings")
                .font(.title)
                .padding(.bottom)
                        
            Text("Mode")
            Picker(selection: self.$data.expertMode, label: Text("Mode")) {
                Group {
                    Text("Regular").tag(false)
                    Text("Expert").tag(true)
                }
            }.pickerStyle(SegmentedPickerStyle())
            .padding(.bottom)
            
            
            Text("X Color")
            ColorPicker(selectedColor: self.$data.xColor)
                .padding(.bottom)
            
            Text("O Color")
            ColorPicker(selectedColor: self.$data.oColor)
            
            Spacer()
        }.padding()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().environmentObject(Data())
    }
}
