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
                
                StatsView()
                    .tabItem {
                        Label {
                            Text("Stats")
                        } icon: {
                            Image(systemName: "chart.bar.fill")
                        }
                    }
                
                AccountView()
                    .tabItem {
                        Label {
                            Text("Account")
                        } icon: {
                            Image(systemName: "person.fill")
                        }
                    }
                
//                    .toolbarBackground(.visible, for: .tabBar)
//                    .toolbarBackground(Color.yellow,for: .tabBar)
                    .toolbar(.hidden, for: .navigationBar)
            }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        TabsView()
    }
}
