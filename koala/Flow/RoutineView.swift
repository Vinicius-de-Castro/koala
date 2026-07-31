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
    
    //ESSA PARTE É APENAS A ANIMAÇÃO DA CONTRAÇÃO
    func animateCircle() {
        // Definimos um ciclo total. Exemplo: 6s (contrair) + 3s (segurar) + 3s (relaxar) = 12 segundos
        let tempoDoCiclo = 12
        let segundoAtualDoCiclo = timerElapsed % tempoDoCiclo
        
        // Mudamos o estado do círculo baseando-se puramente no segundo atual
        withAnimation(.linear(duration: 1.0)) {
            if segundoAtualDoCiclo < 6 {
                // Primeiros 6 segundos: Círculo expandido (Contração/Grow)
                animationStep = .grow
                scale = 1.5
            } else if segundoAtualDoCiclo < 9 {
                // Dos segundos 6 a 9: Círculo encolhe (Relaxamento/Contract)
                animationStep = .contract
                scale = 1.0
            } else {
                // Dos segundos 9 a 12: Círculo parado no tamanho normal (Hold/Stop)
                animationStep = .hold
                scale = 1.0
            }
        }
    }
//accessibiltyValue()
    func startTimer() {
        // Evita criar timers duplicados se o usuário apertar "Play" várias vezes
        if timer != nil { return }
        
        isTimerRunning = true
        
        // Dispara a animação imediatamente ao iniciar
        animateCircle()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            timerElapsed += 1
            
            // A cada 1 segundo que passa, a animação avalia o que deve fazer
            animateCircle()
        }
    }

    func stopTimer() {
        isTimerRunning = false
        timer?.invalidate()
        timer = nil // Limpa o timer da memória
        
        // Opcional: Reseta o círculo para o tamanho normal ao pausar
        withAnimation(.easeOut(duration: 0.5)) {
            scale = 1.0
        }
    }
    
    var body: some View {
        
        let bgColor: Color = (routine!.type == .kegel ? Color.kegelLight : .stretchLight)
        
        let buttonColor: Color = (routine!.type == .kegel ? Color.kegelLight : .stretchGreen)
        
        let textColor: Color = (routine!.type == .kegel ? Color.kegelLight : .stretchDark)
        
        let colorKegel: Color = (routine!.type == .kegel ? .kegelCircle: .stretchGreen)
        
        let displayTime = timeRemaining - timerElapsed
        
        
        if !isUserDone {
            ZStack (alignment: .center) {
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [.gray .opacity(0.1) , bgColor, bgColor .opacity(0.5)]), startPoint: .top, endPoint: .bottom))
                
                    .ignoresSafeArea()
                
                
                //O BOTÀO DE DESCANSO DOS ALONGAMENTOS
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
                                    .stretchDark,
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
                            .padding(.vertical, 40)
                        
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

                                
                                    .foregroundStyle(RadialGradient(colors: [.white, .kegelLight, .kegelDark], center: .center, startRadius: 0, endRadius: 240))
                                Circle()
                                
                                    .fill(.white)
                                    .frame(width: 120, height: 120)
                                
                                Text((String(format: "%02d", displayTime)))
                                    .foregroundStyle(.black)
                                    .fontWeight(.bold)
                                    .font(.system(size: 30))
                                    .accessibilityLabel("\(Int(displayTime/60))%")//
                            }
                            .frame(maxHeight: .infinity)
                        }
                        if routine!.type == .kegel{
                           
                        }
                        ZStack {
                            
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
                    }
                    label: {
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
