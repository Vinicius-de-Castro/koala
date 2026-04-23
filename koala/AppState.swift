//
//  AppState.swift
//  koala
//
//  Created by User on 23/04/26.
//
import Observation

@Observable
class Memory {
    var moves: [Move] = [
        Move(
            name: "Elevação de joelhos",
             description: "Levante um joelho em direção ao peito enquanto mantém o outro pé no chão. Alterne as pernas em movimentos lentos e contínuos. Repita 10 vezes para cada perna.",
             lenght: 20,
             type: .stretch,
             level: .light,
             pattern: nil,
             illustration: nil
            )
    ]
    var routines: [Routine] = [
        Routine(name: "Alongamento matinal",
                description: "Um alongamento leve para começar o dia",
                type: .stretch,
                level: .light,
                tags: [
                    "Manhã", "Leve"
                ],
                moveset: []
                
               )
    ]
}
