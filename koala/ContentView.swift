//
//  ContentView.swift
//  koala
//
//  Created by User on 17/04/26.
//

import SwiftUI

enum Tabs {
    case main
    case kegel
    case stretch
}

struct ContentView: View {
    @Environment(AppState.self) private var appState
    @State private var currentTab: Tabs = .main
    
    var body: some View {
      
        TabView(selection: $currentTab) {
            
            Tab("Sugestões", systemImage: "ring.dashed", value: Tabs.main) {
                HomeView()
            }
            
            Tab("Kegel", systemImage: "camera.macro", value: Tabs.kegel) {
                KegelView()
            }
            Tab("Alongamentos", systemImage: "figure.strengthtraining.functional", value: Tabs.stretch) {
                StretchView()
                    .navigationTitle(Text("Teste"))
            }
        }
        .tint(.kegelPurple)
    }
}

#Preview {
    @Previewable @State var appState = AppState(selectedTab: .main)
    ContentView()
        .environment(appState)
}
