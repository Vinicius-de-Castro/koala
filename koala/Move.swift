//
//  Move.swift
//  koala
//
//  Created by User on 23/04/26.
//

import SwiftUI

class Move {
    let name: String
    let description: String
    let lenght: Int
    
    let type: moveType
    let level: Intensity
    
    let tags: [String] = []
    let pattern: [Int]? // kegel-only
    let illustration: Image? //stretch-only
    
    init(name: String, description: String, lenght: Int, type: moveType, level: Intensity, pattern: [Int]?, illustration: Image?) {
        self.name = name
        self.description = description
        self.lenght = lenght
        self.type = type
        self.level = level
        self.pattern = pattern
        self.illustration = illustration
    }
}
