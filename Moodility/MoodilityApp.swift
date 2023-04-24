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
            HomeView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}

struct HomeView: View {
    
    @State var userExists = UserDefaults.standard.bool(forKey: "userExists")
    
    var body: some View {
        NavigationView {
            if userExists {
                TabsView()
            } else {
                LoginView()
            }
        }
    }
}
