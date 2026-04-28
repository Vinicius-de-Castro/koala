//
//  koalaApp.swift
//  koala
//
//  Created by User on 17/04/26.
//

import SwiftUI

@main
struct koalaApp: App {
    
    @State private var appState = AppState(selectedTab: .main)
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .environment(appState)
    }
}
