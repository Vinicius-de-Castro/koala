//
//  KegelShape.swift
//  koala
//
//  Created by User on 27/04/26.
//

import SwiftUI


struct KegelShapeBackup: View {
    @State var isAnimating = false
    
    @State var routine: Routine?
    
    @State var timerElapsed: Int = 0
    
    @State var timer: Timer? = nil
    
    @State var isTimerRunning = false
    
    @State var isUserResting = false
    
    @State var currentMoveSetIndex = 0
    
    
    //
    //    let fraction: Double
    //    let primatyText: String
    //    let secondText: String
    
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
    
    @State var scale: CGFloat = 1
    @State var animationStep: AnimationStep = .grow
    
    
    enum AnimationStep {
        case grow, hold, contract, stop
    }
    
    func animateCircle() {
        switch animationStep {
        case .grow:
            withAnimation(.easeIn(duration: 6)) {
                scale = 1.5
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 6){
                animationStep = .contract
            }
        case .hold:
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                animationStep = .grow
            }
        case .contract:
            withAnimation(.easeIn(duration: 3)) {
                scale = 1
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                animationStep = .hold
            }
        case .stop:
            //logica depois q terminar 10x
           
            print("dsa")
        }

    }
    
    var body: some View {
        //BACKGROUN DA TELA INTEIRA
        var displayTime = timeRemaining - timerElapsed
        
        let bgColor: Color = (routine!.type == .kegel ? Color.kegelPurple : .stretchGreen)
        
        ZStack {
        Rectangle()
            .fill(LinearGradient(gradient: Gradient(colors: [.white, bgColor .opacity(0.2), bgColor]), startPoint: .top, endPoint: .bottom))
            .ignoresSafeArea()
            Circle()
                .scale(scale)
//
                .frame(width: 160, height: 160)
                .onAppear {
                    animateCircle()
                }
                .onChange(of: animationStep) { _, _ in
                    animateCircle()
                }
//
            
                .foregroundStyle(RadialGradient(colors: [.kegelPurple, .white], center: .center, startRadius: 0, endRadius: 200))
            Circle()
                .fill(.white)
                .frame(width: 100, height: 100)
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
                    
                    Spacer()
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
        
        
        .padding()
        
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
    KegelShapeBackup(routine: Memory.routines["MORNING_KEGEL"])
}
