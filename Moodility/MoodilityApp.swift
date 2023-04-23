//
//  MoodilityApp.swift
//  Moodility
//
//  Created by Muhammad Suleman on 4/20/23.
//

import SwiftUI

@main
struct MoodilityApp: App {
    
    @StateObject private var dataController = PersistenceVM()
    
    var body: some Scene {
        WindowGroup {
            TabsView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
