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
            VStack{
                CarrouselView()
                CardView(
                    thisRoutine: Memory.routines["MORNING_STRETCH"]!
                )
                .onTapGesture {
                    selectedRoutine = Memory.routines["MORNING_STRETCH"]!
                }
                .frame(height: 150)
                .padding()
                Spacer()
            }
            .navigationDestination(item: $selectedRoutine) { routine in
                StretchDetailView(routine: routine)
            }
        }
    }
}

#Preview {
    HomeView()
}
