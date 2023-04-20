//
//  HomeView.swift
//  Moodility
//
//  Created by Muhammad Suleman on 4/20/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            
            ContentView()
                .tabItem {
                    Label {
                        Text("Moods")
                    } icon: {
                        Image(systemName: "house")
                    }
                }
            
            Text("Hello")
                .tabItem {
                    Label {
                        Text("Moods")
                    } icon: {
                        Image(systemName: "house")
                    }
                }
            
            Text("Hello")
                .tabItem {
                    Label {
                        Text("Moods")
                    } icon: {
                        Image(systemName: "house")
                    }
                }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
