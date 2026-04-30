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
            Tab("Início", systemImage: "house.fill", value: Tabs.main) {
                HomeView()
            }
            Tab("Kegel", systemImage: "figure.mind.and.body", value: Tabs.kegel) {
                KegelView()
            }
            Tab("Alongamentos", systemImage: "figure.strengthtraining.functional", value: Tabs.stretch) {
                StretchView()
                    .navigationTitle(Text("Teste"))
            }
            //Tab("KegelTeste",systemImage: "circle.fill"){
              //  KegelShape(fraction: <#T##Double#>, primatyText: <#T##String#>, secondText: <#T##String#>)
            //}
        }
    }
}

#Preview {
    @Previewable @State var appState = AppState(selectedTab: .main)
    ContentView()
        .environment(appState)
}
