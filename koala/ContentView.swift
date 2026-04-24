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
            Tab("Home", systemImage: "circle.fill") {
                HomeView()
            }
            Tab("Kegel", systemImage: "circle.fill") {
                KegelView()
            }
            Tab("Alongamentos", systemImage: "circle.fill") {
                StretchView()
            }
        }
    }
}

#Preview {
    ContentView()
}
