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
        
        let bgColor: Color = (routine!.type == .kegel ? Color.kegelPurple : .stretchLight)
        
        let buttonColor: Color = (routine!.type == .kegel ? Color.kegelPurple : .stretchGreen)
        
        var displayTime = timeRemaining - timerElapsed
        
        ZStack (alignment: .center) {
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: [.white, bgColor .opacity(0.2), bgColor]), startPoint: .top, endPoint: .bottom))
                .ignoresSafeArea()
            VStack {
                if isUserResting {
                    
                    Text("Descanse")
                        .font(.largeTitle)
                        .fontWeight(.bold)
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
                            ) // 1
                            .stroke(
                                buttonColor,
                                style: StrokeStyle(
                                    lineWidth: 30,
                                    lineCap: .round
                                )
                            )
                            .rotationEffect(.degrees(-90))
                            .animation(.linear, value: CGFloat(timerElapsed))
                        
                        
                        Text(String(format: "%02d", displayTime%60))
                            .foregroundStyle(.white)
                            .font(.system(size: 180))
                            .fontWeight(.black)
                            .padding()
                            .padding(.horizontal)
                    }
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
                            //                            .stroke(.white, lineWidth: 2)
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
                        if currentMoveSetIndex < routine!.length - 1 {
                            timerElapsed = 0
                            if isUserResting{
                                currentMoveSetIndex+=1
                            }
                            isUserResting = !isUserResting
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
                        if currentMoveSetIndex < routine!.length - 1 {
                            currentMoveSetIndex += 1
                        }
                        else {
                            print("User finished")
                        }
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
