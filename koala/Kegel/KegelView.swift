//
//  KegelView.swift
//  koala
//
//  Created by User on 24/04/26.
//

import SwiftUI

struct KegelView: View {
    
    @State private var selectedRoutine: Routine?
    
    var body: some View {
        NavigationStack {
            ScrollView{
                Text("Rotinas de Kegel")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                    .containerRelativeFrame(.horizontal, alignment: .leading)
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

