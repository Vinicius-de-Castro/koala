//
//  HomeView.swift
//  koala
//
//  Created by User on 24/04/26.
//

import SwiftUI

struct HomeView: View {
    
    @State var recomendedRoutine: Routine
    
    var body: some View {
        VStack{
            Text("Home")
            CardView(thisRoutine: recomendedRoutine)
        }
    }
}

#Preview {
    HomeView(
        recomendedRoutine: Memory.routines["MORNING_ROUTINE"]!
    )
}
