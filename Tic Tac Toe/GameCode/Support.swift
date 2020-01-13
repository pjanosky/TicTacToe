//
//  Support.swift
//  Tic Tac Toe
//
//  Created by Peter Janosky on 1/9/20.
//  Copyright © 2020 Peter Janosky. All rights reserved.
//

import Foundation
import SwiftUI

enum Marker: CustomStringConvertible, CaseIterable {
    case x, o
    var opposite: Marker {
        if self == .x {
            return .o
        } else {
            return .x
        }
    }
    var description: String {
        switch self {
            case .x: return "X"
            case .o: return "O"
        }
    }
    
    static var random: Self {
        return allCases.randomElement()!
    }
}

struct Coordinate: Equatable, Hashable {
    var row: Int
    var col: Int
    init(_ row: Int, _ col: Int) {
        self.row = row
        self.col = col
    }
}
