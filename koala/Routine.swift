//
//  Routine.swift
//  koala
//
//  Created by User on 23/04/26.
//

class Routine {
    let name: String
    let description: String
    var length: Int
    
    let type: moveType
    let level: Intensity
    let tags: [String]
    let moveset: [Move]
    
    init(name: String, description: String, type: moveType, level: Intensity, tags: [String], moveset: [Move]) {
        self.name = name
        self.description = description
        self.length = 0
        self.moveset = moveset
        self.type = type
        self.level = level
        self.tags = tags
        
        for move in moveset {
            self.length += move.lenght
        }
    }
}
