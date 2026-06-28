//
//  Routine.swift
//  koala
//
//  Created by User on 23/04/26.
//

import Foundation

class Routine: Identifiable, Hashable, Equatable {
    let id: UUID = UUID()
    let name: String
    let description: String
    var length: Int
    var count: Int
    
    let type: moveType
    let level: Intensity
    let tags: [String]
    let moveset: [Move]
    let image: String
    var reps: Int
    
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
        self.reps = 0
        
        for move in moveset {
            length += move.lenght
            count+=1
        }
        
        if type == .kegel {
            for move in moveset {
                self.reps += move.repetitions!
            }
        }
    }    
    static func ==(lhs: Routine, rhs: Routine) -> Bool {
       return lhs.id == rhs.id
   }

   func hash(into hasher: inout Hasher) {
       hasher.combine(id)
   }
}
