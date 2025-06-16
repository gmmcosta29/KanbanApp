//
//  KanbanAppApp.swift
//  KanbanApp
//
//  Created by Guilherme Costa on 09/06/2025.
//

import SwiftUI
import SwiftData

@main
struct KanbanApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Card.self, Column.self])
    }

}
