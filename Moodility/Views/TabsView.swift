//
//  TabsView.swift
//  Moodility
//
//  Created by Muhammad Suleman on 4/20/23.
//

import SwiftUI

struct TabsView: View {
    var body: some View {
        TabView {
            
            MoodsView()
                .tabItem {
                    Label {
                        Text("Moods")
                    } icon: {
                        Image(systemName: "house")
                    }
                }
            
            Text("Coming Soon")
                .tabItem {
                    Label {
                        Text("Stats")
                    } icon: {
                        Image(systemName: "chart.bar.fill")
                    }
                }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        TabsView()
    }
}
