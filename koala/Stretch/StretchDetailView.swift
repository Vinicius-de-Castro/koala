//
//  StretchDetailView.swift
//  koala
//
//  Created by User on 28/04/26.
//

import SwiftUI

struct StretchDetailView: View {
    
    @State var routine: Routine
    
    var screenHeight = UIScreen.main.bounds.size.height
    
    var body: some View {
        
        let moveColor: Color = (routine.type == .kegel ? Color.kegelPurple : .stretchGreen)
        
        ScrollView {
            VStack (alignment: .leading){
                ZStack (alignment: .bottomLeading){
                    Image(routine.image)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .frame(height: screenHeight*0.4, alignment: .center)
                        .ignoresSafeArea()
                        .clipped()
                        .containerRelativeFrame(.horizontal)
                    Rectangle()
                        .fill(LinearGradient(gradient: Gradient(colors: [.white .opacity(0), .white .opacity(0.6), .white]), startPoint: .top, endPoint: .bottom))
                        .ignoresSafeArea()
                    HStack{
                        ForEach(routine.tags, id: \.self) { tag in
                            TagView(tag: tag, type: routine.type)
                        }
                    }
                    .padding(.horizontal)
                }
                Label("Iníciar exercício", systemImage: "play.fill")
                    .font(.title)
                    .fontWeight(.medium)
                    .foregroundStyle(.white)
                    .padding(.vertical, 20)
                    .frame(maxWidth: .infinity)
                    .background {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(moveColor)
                    }
                    .padding()
                    .onTapGesture {
                        print("pressed")
                    }
                Text(routine.description)
                    .font(.body)
                    .padding(.horizontal)
                Label("Respeite seu corpo. Ao sinal de qualquer desconforto, pare imediatamente.", systemImage: "exclamationmark.triangle.fill")
                    .font(.body)
                    .fontWeight(.medium)
                    .padding(.horizontal)
            }
        }
    }
}

#Preview {
    if let routine = Memory.routines["MORNING_STRETCH"] {
        StretchDetailView(routine: routine)
    }
}
