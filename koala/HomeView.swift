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
            Text("Home")
            CardView(thisRoutine: Memory.routines["MORNING_ROUTINE"] ?? Memory.routines["DEFAULT"]!)
        }
    }
}

#Preview {
    HomeView()
}
