//
//  KegelView.swift
//  koala
//
//  Created by User on 24/04/26.
//

import SwiftUI

struct KegelView: View {

    var body: some View {
        //TIMER DO KEGEL
        Text("Rotinas de Kegel")
            .font(.system(size: 22, weight: .bold))
        ScrollView {
            ForEach(Array(Memory.routines.keys), id: \.self) { key in
                CardView(thisRoutine: Memory.routines[key]!)
                    .frame(height: 150)
            }
        }
    }
}

