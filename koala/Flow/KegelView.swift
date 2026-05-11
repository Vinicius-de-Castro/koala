//
//  KegelView.swift
//  koala
//
//  Created by User on 24/04/26.
//

import SwiftUI

struct KegelView: View {
    
    @State private var selectedRoutine: Routine?
    
    @State private var showTutorial: Bool = false

    
    var body: some View {
        NavigationStack {
            
            ScrollView{
               
                Text("Rotinas de Kegel")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                    .containerRelativeFrame(.horizontal, alignment: .leading)
                    

                ZStack {
                    Color(.kegelLight)
                    HStack {
                        Label("O que é Kegel?", systemImage: "camera.macro")
                            .padding()
                            .padding()
                            .foregroundStyle(.white)
                            .font(.title)
                            .fontWeight(.bold)
                            .aspectRatio(contentMode: .fit)
                        
                        Image(systemName: "chevron.right")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                            .foregroundStyle(Color.white)
                            .clipped()
                            .padding(.trailing)
                    }
                }
                .clipShape(
                    RoundedRectangle(cornerRadius: 24)
                )
                .padding(.bottom)
                .padding(.horizontal)
//                .navigationDestination(for: String.self) {_ in 
//                    KegelTutorialView()
//                }
                .onTapGesture {
                    showTutorial = true
                }
                .sheet(isPresented: $showTutorial) {        KegelTutorialView()
                }
                
                
                ForEach(Array(Memory.routines.keys), id: \.self) { key in
                    if Memory.routines[key]?.type == .kegel {
                        CardView(thisRoutine: Memory.routines[key]!)
                            .padding(.horizontal)
                            .onTapGesture {
                                selectedRoutine = Memory.routines[key]
                            }
                    }
                }
            }
            .navigationDestination(item: $selectedRoutine) { routine in
                DetailView(routine: routine)
            }
        }
    }
}

#Preview {
    KegelView()
}
