//
//  DetailView.swift
//  koala
//
//  Created by User on 28/04/26.
//

import SwiftUI

struct DetailView: View {
    
    @State var routine: Routine
    
    @State private var selectedRoutine: Routine?
    
    var screenHeight = UIScreen.main.bounds.size.height
    
    var body: some View {
        
        let moveColor: Color = (routine.type == .kegel ? Color.kegelLight : .stretchGreen)
        
        NavigationStack {
            
            ScrollView {
                VStack (alignment: .leading){
                    ZStack (alignment: .bottomLeading){
                        Color(moveColor)
                        Image(routine.image)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .frame(height: screenHeight*0.55, alignment: .center)
                            .ignoresSafeArea()
                            .clipped()
                            .containerRelativeFrame(.horizontal)
                            .accessibilityHidden(true)
                        
                        Rectangle()
                            .fill(LinearGradient(gradient: Gradient(colors: [Color("testColor") .opacity(0), Color("testColor") .opacity(0), Color("testColor")]), startPoint: .top, endPoint: .bottom))
                        
                            .ignoresSafeArea()
                        
                        
                        
                        VStack (alignment: .leading){
                            Text(routine.name)
                                .foregroundColor(.primary)
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                                .padding(.horizontal)
                                .padding(.bottom, 1)
                            Label("Ao sinal de qualquer desconforto, pare imediatamente.", systemImage: "exclamationmark.triangle.fill")
                             .font(.body)
                            .fontWeight(.medium)
                            .padding(.horizontal, 10)
                            .padding()
                            .foregroundColor(.primary)
                            
                            //TRATAMENTO DAS TAGS NA PÁGINA
                            HStack{
                                ForEach(routine.tags, id: \.self) { tag in
                                    TagView(tag: tag, type: routine.type)
                                }
                            }
                            .padding(.horizontal)
                            .padding(.bottom, 0)
                        }
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
                            selectedRoutine = routine
                        }
                    //PARTE DE INTERAÇÃO PARA PROXIMA PAGINA

//       
                        }
                    
                }
            .ignoresSafeArea()
            }
            .navigationDestination(item: $selectedRoutine) { routine in
                RoutineView(routine: routine)
                    }
        }
    }


#Preview {
    if let routine = Memory.routines["MORNING_STRETCH"] {
        DetailView(routine: routine)
    }
}
