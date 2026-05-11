//
//  RoutineView.swift
//  koala
//
//  Created by User on 28/04/26.
//

import SwiftUI

struct RoutineView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State var routine: Routine?
    
    @State var timerElapsed: Int = 0
    
    @State var timer: Timer? = nil
    
    @State var isTimerRunning = false
    
    @State var isUserResting = false
    
    @State var isUserDone = false
    
    @State var currentMoveSetIndex = 0
    
    @State var scale: CGFloat = 1
    
    @State var animationStep: AnimationStep = .grow
    
    var screenHeight = UIScreen.main.bounds.size.height
    
    var screenWidth = UIScreen.main.bounds.size.width
    
    var pauseState: AnimationStep = .grow
    
    var currentMove: Move? {
        if currentMoveSetIndex < routine!.count{
            return routine?.moveset[currentMoveSetIndex]
        }
        return nil
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
    
    enum AnimationStep {
        case grow, hold, contract, stop
    }
    
    func animateCircle() {
        switch animationStep {
        case .grow:
            withAnimation(.easeIn(duration: TimeInterval(6 - (timerElapsed%6)))) {
                scale = 1.5
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 6){
                if(isTimerRunning) {
                    animationStep = .contract
                }
            }
        case .hold:
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                if(isTimerRunning) {
                    animationStep = .grow
                }
            }
        case .contract:
            withAnimation(.easeIn(duration: 3)) {
                scale = 1
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                if (isTimerRunning) {
                    animationStep = .hold
                }
            }
        case .stop:
            print("dsa")
        }
        
    }
    func startTimer() {
        animateCircle()
        animationStep = .grow
        isTimerRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { tempTimer in
            timerElapsed += 1
        }
        
    }
    func stopTimer(){
        withAnimation() {
            scale = 1
        }
        isTimerRunning = false
        timer?.invalidate()
    }
    
    var body: some View {
        
        let bgColor: Color = (routine!.type == .kegel ? Color.kegelLight : .stretchLight)
        
        let buttonColor: Color = (routine!.type == .kegel ? Color.kegelPurple : .stretchGreen)
        
        let textColor: Color = (routine!.type == .kegel ? Color.kegelDark : .stretchDark)
        
        let displayTime = timeRemaining - timerElapsed
        
        
        if !isUserDone {
            ZStack (alignment: .center) {
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [.white, bgColor .opacity(0.3), bgColor]), startPoint: .top, endPoint: .bottom))
                
                    .ignoresSafeArea()
                
                VStack {
                    if isUserResting {
                        Text("Descanse")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding()
                        ZStack {
                            Circle()
                                .fill(.white)
                                .stroke(
                                    bgColor,
                                    lineWidth: 30
                                )
                            
                            
                            Circle()
                                .trim(
                                    from: 0,
                                    to: CGFloat(timerElapsed+1)/30
                                )
                                .stroke(
                                    buttonColor,
                                    style: StrokeStyle(
                                        lineWidth: 30,
                                        lineCap: .round
                                    )
                                )
                                .rotationEffect(.degrees(-90))
                                .animation(.easeInOut, value: CGFloat(timerElapsed))
                            
                            
                            Text(String(format: "%02d", displayTime%60))
                                .foregroundStyle(textColor)
                                .font(.system(size: 160))
                                .fontWeight(.black)
                                .padding()
                                .padding(.horizontal)
                        }
                        .frame(maxHeight: .infinity)
                        .padding()
                        .padding()
                        .padding()
                        .frame(minWidth: 50)
                    }
                    else {
                        
                        Text(currentMove!.name)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        if routine!.type == .stretch {
                            Image(currentMove!.image)
                                .resizable()
                                .scaledToFit()
                        }
                        else {
                            ZStack {
                                Circle()
                                    .scale(scale)
                                    .frame(width: 180, height: 180)
                                    .onAppear {
                                        animateCircle()
                                    }
                                    .onChange(of: animationStep) { _, _ in
                                        animateCircle()
                                    }
                                
                                    .foregroundStyle(RadialGradient(colors: [.white, .kegelLight, .kegelPurple], center: .center, startRadius: 0, endRadius: 240))
                                Circle()
                                
                                    .fill(.white)
                                    .frame(width: 120, height: 120)
                                
                                Text((String(format: "%02ds", displayTime)))
                                    .foregroundStyle(.black)
                                    .fontWeight(.bold)
                                    .font(.system(size: 30))
                            }
                            .frame(maxHeight: .infinity)
                        }
                        
                        
                        Text(currentMove!.description)
                            .multilineTextAlignment(.center)
                            .padding()
                            .padding(.horizontal)
                            .font(.title2)
                            .fontWeight(.medium)
                        if routine!.type == .stretch {
                            Label("\(displayTime/60):" + String(format: "%02d", displayTime%60), systemImage: "clock.fill")
                                .foregroundStyle(.white)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .padding()
                                .background {
                                    RoundedRectangle(cornerRadius: 100)
                                        .fill(.quaternary)
                                }
                                .padding(.horizontal)
                        }
                        
                    }
                    
                    Spacer()
                    
                    HStack {
                        Button {
                            if currentMoveSetIndex > 0 {
                                timerElapsed = 0
                                currentMoveSetIndex-=1
                                isUserResting = !isUserResting
                            }
                        } label: {
                            Image(systemName: "chevron.backward.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: 70, maxHeight: 70)
                        }
                        .tint(buttonColor)
                        .background {
                            Circle()
                                .fill(.white)
                                .padding()
                        }
                        .padding()
                        if isTimerRunning{
                            Button {
                                stopTimer()
                            } label: {
                                Image(systemName: "pause.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: 100, maxHeight: 100)
                                
                            }
                            .tint(buttonColor)
                            .background {
                                Circle()
                                    .fill(.white)
                                    .padding()
                            }
                        }
                        else {
                            Button {
                                startTimer()
                            } label: {
                                Image(systemName: "play.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: 77 , maxHeight: 77)
                                
                            }
                            .tint(buttonColor)
                            .background {
                                Circle()
                                    .fill(.white)
                                    .padding()
                                
                            }
                        }
                        
                        Button {
                            if currentMoveSetIndex < routine!.length - 2 {
                                timerElapsed = timeRemaining
                            }
                        } label: {
                            Image(systemName: "chevron.forward.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: 70, maxHeight: 70)
                        }
                        .tint(buttonColor)
                        .background {
                            Circle()
                                .fill(.white)
                                .padding()
                        }
                        .padding()
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
                            if currentMoveSetIndex < routine!.count - 1 {
                                currentMoveSetIndex += 1
                            }
                            else {
                                isUserDone = true
                            }
                        }
                    }
                }
                
            }
            .toolbar(.hidden, for: .tabBar)
        }
        //PROXIMO EXERCICIO
        
        
        
        
        
        //COMEMORAÇÃO
        else {
            
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.white, bgColor .opacity(0.3), bgColor]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                VStack {
                    if (routine!.type == .stretch) {
                        Image("StretchFinish")
                            .resizable()
                            .scaledToFit()
                    }
                    else {
                        Image("KegelFinish")
                            .resizable()
                            .scaledToFit()
                    }
                    
                    Text("Parabéns!")
                        .font(.system(size: 64))
                        .fontWeight(.bold)
                        .padding(20)
                        .foregroundStyle(textColor)
                    
                    Text("Você concluiu com sucesso a rotina de exercícios \(routine!.name)!")
                        .font(.title2)
                        .fontWeight(.medium)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .padding(.horizontal)
                    
                    Spacer()
                    
                    //BOTAO DE FECHAR//////
                    
                    //KegelView()
                    Button {
                        dismiss.callAsFunction()
                    } label: {
                        Text("Fechar")
                            .font(.title)
                            .fontWeight(.medium)
                            .tint(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 32)
                                    .fill(buttonColor)
                            )
                        
                            .padding()
                    }
                    
                }
                
                .toolbar(.hidden, for: .tabBar)
                .navigationBarBackButtonHidden(true)
            }
        }
    }
}

#Preview {
    RoutineView(routine: Memory.routines["MORNING_KEGEL"])
}
