//
//  TimerTeste.swift
//  koala
//
//  Created by User on 28/04/26.
//

import SwiftUI

struct TimerTeste: View {
    private var timer: Timer = Timer(workinSeconds: 10, pauseinSeconds: 5)
    var body: some View {
        Text("\(timer.secondLeft))")
        Text("\(timer.secondsLeftString)")
        Text("\(timer.mode.rawValue)")
        
    }
}

#Preview {
    TimerTeste()
}
