//
//  HomeView.swift
//  koala
//
//  Created by User on 24/04/26.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedRoutine: Routine?
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .leading){
                CarrouselView()
                Text("Recomendado")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                    .foregroundStyle(.stretchGreen)
                    .accessibilityLabel("Recomendado")
                        
                    
                CardView(
                    thisRoutine: Memory.routines["MORNING_STRETCH"]!
                )
                .onTapGesture {
                    selectedRoutine = Memory.routines["MORNING_STRETCH"]!
                }
                .frame(height: 150)
                .padding(.horizontal)
                .padding(.bottom)
                Spacer()
            }
            .navigationDestination(item: $selectedRoutine) { routine in
                DetailView(routine: routine)
            }
        }
    }
}

#Preview {
    HomeView()
}
