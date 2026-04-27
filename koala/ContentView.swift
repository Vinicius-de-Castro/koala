//
//  ContentView.swift
//  koala
//
//  Created by User on 17/04/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house.fill") {
                HomeView()
            }
            Tab("Kegel", systemImage: "figure.mind.and.body") {
                KegelView()
            }
            Tab("Alongamentos", systemImage: "figure.strengthtraining.functional") {
                StretchView()
            }
        }
    }
}

#Preview {
    ContentView()
}
