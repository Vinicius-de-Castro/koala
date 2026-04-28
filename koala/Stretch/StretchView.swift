//
//  StretchView.swift
//  koala
//
//  Created by User on 24/04/26.
//

import SwiftUI

struct StretchView: View {
    var body: some View {
        ScrollView {
            ForEach(Array(Memory.routines.keys), id: \.self) { key in
                if Memory.routines[key]?.type == .stretch {
                    CardView(thisRoutine: Memory.routines[key]!)
                        .padding(.horizontal)
                }
            }
        }
    }
}

#Preview {
    StretchView()
}
