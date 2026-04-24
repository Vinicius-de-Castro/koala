//
//  KegelView.swift
//  koala
//
//  Created by User on 24/04/26.
//

import SwiftUI

struct KegelView: View {
    
    @State var recomendedRoutine: Routine
    
    var body: some View {
        List {
            ForEach(Array(Memory.routines.keys), id: \.self) { key in
                CardView(thisRoutine: Memory.routines[key]!)
            }
        }
    }
}

#Preview {
    KegelView(
        recomendedRoutine: Memory.routines["MORNING_ROUTINE"]!
    )
}
