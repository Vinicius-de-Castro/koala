//
//  StretchRoutineView.swift
//  koala
//
//  Created by User on 28/04/26.
//

import SwiftUI

struct StretchRoutineView: View {
    
    @State var routine: Routine?
    
    @State var timerElapsed: Int = 0
    
    @State var timer: Timer? = nil
    
    @State var isTimerRunning = false
    
    @State var isUserResting = false
    
    @State var currentMoveSetIndex = 0
    
    var currentMove: Move? {
        return routine?.moveset[currentMoveSetIndex]
    }
    
    var timeRemaining: Int {
        if isUserResting {
            return 30
        }
        if let time = currentMove?.lenght {
            return time
        }
        return 0
    }
    
    var body: some View {
        
        let bgColor: Color = (routine!.type == .kegel ? Color.kegelPurple : .stretchGreen)
        
        var displayTime = timeRemaining - timerElapsed
        
        ZStack {
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: [.white, bgColor .opacity(0.2), bgColor]), startPoint: .top, endPoint: .bottom))
                .ignoresSafeArea()
            VStack {
                Text("\(displayTime/60):" + String(format: "%02d", displayTime%60))
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                if isUserResting {
                    Text("Descanse pai")
                        .font(.largeTitle)
                }
                else {
                    Text(currentMove!.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Image(currentMove!.image)
                        .resizable()
                        .scaledToFit()
                    
                    Text(currentMove!.description)
                        .multilineTextAlignment(.center)
                        .padding()
                        .font(.title3)
                        .fontWeight(.medium)
                }
                
                
                if isTimerRunning{
                    Button("Pausar", systemImage: "pause.fill") {
                        stopTimer()
                    }
                    .font(.largeTitle)
//                    .fontWeight()
                    .tint(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background {
                        RoundedRectangle(cornerRadius: 100)
                            .fill(.quaternary)
                            .stroke(.white, lineWidth: 2)
                    }
                    .padding(.horizontal)
                }
                else {
                    Button("Continuar", systemImage: "play.fill") {
                        startTimer()
                    }
                    .font(.largeTitle)
//                    .fontWeight()
                    .tint(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background {
                        RoundedRectangle(cornerRadius: 100)
                            .fill(.quaternary)
                            .stroke(.white, lineWidth: 2)
                    }
                    .padding(.horizontal)
                }
            }
            
            
            .onAppear {
                startTimer()
            }
            .onChange(of: timerElapsed) { _, _ in
                if timerElapsed == timeRemaining {
                    timerElapsed = 0
                    isUserResting = !isUserResting
                    if isUserResting {
                        currentMoveSetIndex += 1
                    }
                }
            }
        }
        .toolbar(.hidden, for: .tabBar)
    }
    
    func startTimer() {
        isTimerRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { tempTimer in
            timerElapsed += 1
        }
        
    }
    func stopTimer(){
        isTimerRunning = false
        timer?.invalidate()
    }
}

#Preview {
    StretchRoutineView(routine: Memory.routines["MORNING_STRETCH"])
}
