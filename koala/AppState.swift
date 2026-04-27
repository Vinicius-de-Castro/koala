//
//  AppState.swift
//  koala
//
//  Created by User on 23/04/26.
//

struct Memory {
    static let moves: [String : Move] = [
        "DEFAULT" : Move(
            name: "MOVIMENTO PADRÃO",
            description: "ALGUM ERRO ACONTECEU",
            lenght: 0,
            type: .stretch,
            level: .light,
            pattern: nil,
            image: "DefaultStretch"
        ),
        "KNEE_UP" : Move(
            name: "Elevação de joelhos",
            description: "Levante um joelho em direção ao peito enquanto mantém o outro pé no chão. Alterne as pernas em movimentos lentos e contínuos. Repita 10 vezes para cada perna.",
            lenght: 20,
            type: .stretch,
            level: .light,
            pattern: nil,
            image: "DefaultStretch"
        )
    ]
    static let routines: [String : Routine] = [
        "DEFAULT" : Routine(
            name: "ROTINA PADRÃO",
            description: "ALGUM ERRO ACONTECEU",
            type: .kegel,
            level: .light,
            tags: [],
            moveset: [
                moves["DEFAULT"]!
            ],
            image: "DefaultStretch"
        ),
        
        "MORNING_ROUTINE" : Routine(
            name: "Alongamento matinal",
            description: "Um alongamento leve para começar o dia",
            type: .stretch,
            level: .light,
            tags: [
                "Manhã", "Leve"
            ],
            moveset: [
                moves["KNEE_UP"]!
            ],
            image: "DefaultStretch"
        )
    ]
}
