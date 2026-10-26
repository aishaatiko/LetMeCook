//
//  LetMeCookApp.swift
//  LetMeCook
//
//  Created by ais on 12/10/26.
//

import SwiftUI
import SwiftData

@main
struct LetMeCookApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(PersistenceController.sharedModelContainer)
    }
}
