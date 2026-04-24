//
//  HomeView.swift
//  koala
//
//  Created by User on 24/04/26.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        VStack{
            CarrouselView()
            CardView(thisRoutine: Memory.routines["MORNING_ROUTINE"]!)
                .frame(height: 150)
        }
    }
}

#Preview {
    HomeView()
}
