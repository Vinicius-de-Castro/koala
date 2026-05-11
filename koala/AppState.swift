//
//  AppState.swift
//  koala
//
//  Created by User on 23/04/26.
//

import Observation

@Observable
class AppState {
    var selectedTab: Tabs
    
    init(selectedTab: Tabs) {
        self.selectedTab = .main
    }
}

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
        
        // --- ALONGAMENTOS ---
        "STRETCH_OMBRO_COSTAS" : Move(
            name: "Ombros e Costas",
            description: "Tente tocar as mãos atrás das costas. Mantenha a coluna ereta. Troque o lado após 30s.",
            lenght: 60,
            type: .stretch,
            level: .light,
            pattern: nil,
            image: "OmbroCostas"
        ),
        "STRETCH_LATERAL" : Move(
            name: "Alongamento Lateral",
            description: "Sente-se com uma perna estendida, incline o tronco suavemente para o lado. Respire fundo.",
            lenght: 90, // 45s cada lado
            type: .stretch,
            level: .light,
            pattern: nil,
            image: "AlongamentoLateral"
        ),
        "STRETCH_CAMEL" : Move(
            name: "Abertura Torácica",
            description: "Ajoelhe-se, coloque as mãos nos calcanhares e olhe para o teto abrindo o tórax suavemente.",
            lenght: 30,
            type: .stretch,
            level: .moderate,
            pattern: nil,
            image: "AberturaToraxica"
        ),
        "STRETCH_CHILD_POSE" : Move(
            name: "Alívio Lombar",
            description: "Joelhos afastados, estique os braços à frente e relaxe o peso no chão. Sinta a lombar relaxar.",
            lenght: 60,
            type: .stretch,
            level: .light,
            pattern: nil,
            image: "AlivioLombar"
        ),
        "STRETCH_HIP_FLEXOR" : Move(
            name: "Flexor de Quadril",
            description: "Ajoelhe-se em um pé, empurre o quadril para frente. Troque o lado após 30s.",
            lenght: 60,
            type: .stretch,
            level: .light,
            pattern: nil,
            image: "FlexorQuadril"
        ),
        "STRETCH_CHEST_OPEN" : Move(
            name: "Abertura de Peitoral",
            description: "Sente-se sobre os calcanhares, entrelace as mãos atrás e abra o peito.",
            lenght: 30,
            type: .stretch,
            level: .light,
            pattern: nil,
            image: "AberturaPeitoral"
        ),
        
        // --- KEGEL ---
        "KEGEL_BASIC" : Move(
            name: "Ritmo Básico",
            description: "Contraia o assoalho pélvico por 3s e relaxe totalmente por 6s. Repita 10x.",
            lenght: 90,
            type: .kegel,
            level: .light,
            pattern: [kegelMove(kegelPhase: .contract, length: 3), kegelMove(kegelPhase: .release, length: 6)],
            image: "KegelIcon",
           repetitions: 10
        ),
        "KEGEL_ENDURANCE" : Move(
            name: "Sustentação",
            description: "Mantenha a contração constante. Contraia o assoalho pélvico por 5s e relaxe por 10s sem prender o ar. Repita 10x.",
            lenght: 150,
            type: .kegel,
            level: .moderate,
            pattern: [kegelMove(kegelPhase: .contract, length: 5), kegelMove(kegelPhase: .release, length: 10)],
            image: "KegelIcon",
            repetitions: 10
        ),
        "KEGEL_ELEVATOR" : Move(
            name: "O Elevador",
            description: "Contraia o assoalho pélvico aos poucos. No topo, segure 3s e desça em 3 etapas. Repita 8x.",
            lenght: 72,
            type: .kegel,
            level: .intense,
            pattern: [kegelMove(kegelPhase: .contract, length: 3),kegelMove(kegelPhase: .hold, length: 3), kegelMove(kegelPhase: .release, length: 3)],
//            pattern: [1,1,1,3,1,1,1],
            image: "KegelIcon",
            repetitions: 8
        )
    ]
    static let routines: [String : Routine] = [
        
        // --- ROTINAS DE ALONGAMENTO ---
        "MORNING_STRETCH" : Routine(
            name: "Despertar Postural",
            description: "Série rápida para alinhar a coluna. Nota: Se sentir desconforto, pare imediatamente.",
            type: .stretch,
            level: .light,
            tags: ["Manhã", "Rápido", "Leve"],
            moveset: [
                moves["STRETCH_CHEST_OPEN"]!,
                moves["STRETCH_OMBRO_COSTAS"]!,
                moves["STRETCH_HIP_FLEXOR"]!
            ],
            image: "AberturaPeitoral"
        ),
        //memory.routines["MORNING_KEGEL"]
        "AFTERNOON_STRETCH" : Routine(
            name: "Alívio Lombar",
            description: "Focada em reduzir a pressão do peso do bebê na lombar e no nervo ciático.",
            type: .stretch,
            level: .moderate,
            tags: ["Tarde", "Moderado"],
            moveset: [
                moves["STRETCH_LATERAL"]!,
                moves["STRETCH_CHILD_POSE"]!
            ],
            image: "AlivioLombar"
        ),
        "EVENING_STRETCH" : Routine(
            name: "Abertura e Sono",
            description: "Prepare o corpo para o descanso com relaxamento pélvico profundo.",
            type: .stretch,
            level: .light,
            tags: ["Noite", "Relaxante"],
            moveset: [
                moves["STRETCH_CAMEL"]!,
                moves["STRETCH_CHILD_POSE"]!
            ],
            image: "AberturaToraxica"
        ),
        
        // --- ROTINAS DE KEGEL ---
        "MORNING_KEGEL" : Routine(
            name: "Conexão Matinal",
            description: "Ative sua musculatura pélvica de forma suave para começar o dia com suporte.",
            type: .kegel,
            level: .light,
            tags: ["Manhã", "Fácil"],
            moveset: [moves["KEGEL_BASIC"]!],
            image: "KegelIcon"
        ),
        "AFTERNOON_KEGEL" : Routine(
            name: "Sustentação e Tônus",
            description: "Treine a resistência para suportar melhor o peso do útero.",
            type: .kegel,
            level: .moderate,
            tags: ["Tarde", "Força"],
            moveset: [moves["KEGEL_ENDURANCE"]!],
            image: "KegelIcon"
        ),
        "EVENING_KEGEL" : Routine(
            name: "Elevador Pélvico",
            description: "Controle avançado de fibras rápidas e lentas para preparação do parto.",
            type: .kegel,
            level: .intense,
            tags: ["Noite", "Difícil"],
            moveset: [moves["KEGEL_ELEVATOR"]!],
            image: "KegelIcon"
        )
    ]
}
