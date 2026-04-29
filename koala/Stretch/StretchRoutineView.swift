//
//  StretchRoutineView.swift
//  koala
//
//  Created by User on 28/04/26.
//

import SwiftUI

struct StretchRoutineView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State var routine: Routine?
    
    @State var timerElapsed: Int = 0
    
    @State var timer: Timer? = nil
    
    @State var isTimerRunning = false
    
    @State var isUserResting = false
    
    @State var isUserDone = false
    
    @State var currentMoveSetIndex = 0
    
    var screenHeight = UIScreen.main.bounds.size.height
    
    var screenWidth = UIScreen.main.bounds.size.width
    
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
    
    var body: some View {
        
        let bgColor: Color = (routine!.type == .kegel ? Color.kegelPurple : .stretchLight)
        
        let buttonColor: Color = (routine!.type == .kegel ? Color.kegelPurple : .stretchGreen)
        
        var displayTime = timeRemaining - timerElapsed
        
        
        if !isUserDone {
            ZStack (alignment: .center) {
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [.white, bgColor .opacity(0.2), bgColor]), startPoint: .top, endPoint: .bottom))
                    .ignoresSafeArea()
                VStack {
                    if isUserResting {
                        Text("Descanse e relaxe")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding()
                        ZStack {
                            Circle()
                                .fill(.quaternary)
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
                                .foregroundStyle(.white)
                                .font(.system(size: 180))
                                .fontWeight(.black)
                                .padding()
                                .padding(.horizontal)
                        }
                        .frame(maxHeight: .infinity)
                        .padding()
                        .padding()
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
                                .frame(maxWidth: 80, maxHeight: 80)
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
                                    .frame(maxWidth: 100, maxHeight: 100)
                                
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
                                .frame(maxWidth: 80, maxHeight: 80)
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
        else {
            
            VStack (alignment: .leading){
                ZStack(alignment: .bottomLeading){
                    Image(routine!.image)
                        .resizable()
                        .scaledToFill()
                    
                    Rectangle()
                        .fill(LinearGradient(gradient: Gradient(colors: [.white .opacity(0), .white .opacity(0.3), .white]), startPoint: .top, endPoint: .bottom))
                        .ignoresSafeArea()
                    
                    Text("Parabéns!")
                        .font(.system(size: 64))
                        .fontWeight(.bold)
                        .padding(20)
                }
                .frame(maxWidth: screenWidth, maxHeight: screenWidth)
                
                Text("Você concluiu com sucesso a rotina de exercícios \(routine!.name)!")
                    .font(.title)
                    .padding(.horizontal)
                
                Spacer()
                Button {
                    dismiss.callAsFunction()
                } label: {
                    Text("Fechar")
                        .font(.largeTitle)
                        .fontWeight(.bold)
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
