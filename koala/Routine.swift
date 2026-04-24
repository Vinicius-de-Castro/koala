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
    var count: Int
    
    let type: moveType
    let level: Intensity
    let tags: [String]
    let moveset: [Move]
    let image: String
    
    init(name: String, description: String, type: moveType, level: Intensity, tags: [String], moveset: [Move], image: String) {
        self.name = name
        self.description = description
        self.length = 0
        self.count = 0
        self.moveset = moveset
        self.type = type
        self.level = level
        self.tags = tags
        self.image = image
        
        for move in moveset {
            length += move.lenght
            count+=1
        }
    }
}
