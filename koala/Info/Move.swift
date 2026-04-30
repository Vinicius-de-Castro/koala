//
//  Move.swift
//  koala
//
//  Created by User on 23/04/26.
//

import SwiftUI

struct kegelMove {
    var kegelPhase: kegelPhase
    var length: Int
}

class Move {
    let name: String
    let description: String
    let lenght: Int
    
    let type: moveType
    let level: Intensity
    
    let tags: [String] = []
    let pattern: [kegelMove]? // kegel-only
    let image: String // Image-code
    
    let repetitions: Int?
    
    init(name: String, description: String, lenght: Int, type: moveType, level: Intensity, pattern: [kegelMove]?, image: String, repetitions: Int? = 1) {
        self.name = name
        self.description = description
        self.lenght = lenght
        self.type = type
        self.level = level
        self.pattern = pattern
        self.image = image
        self.repetitions = repetitions
    }
}
