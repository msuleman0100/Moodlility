//
//  AccountView.swift
//  Moodility
//
//  Created by Muhammad Suleman on 4/23/23.
//

import SwiftUI

struct AccountView: View {
    
    @FetchRequest(sortDescriptors: []) private var users: FetchedResults<User>
    @State var moveToAuthView = false
    @State var username = UserDefaults.standard.string(forKey: "loggedInUsername")
    @State var displayName = UserDefaults.standard.string(forKey: "loggedInUserDisplayName")
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Text(displayName ?? "Unknown")
                .padding(.horizontal)
                .font(.title)
                .fontWeight(.bold)
            
            Text(username ?? "Unknown")
                .padding(.horizontal)
                .padding(.top, 1)
            
            Spacer()
            Spacer()
            NavigationLink("", destination: LoginView()
                .navigationBarBackButtonHidden(true),
                           isActive: $moveToAuthView)
            Button(action: {
                UserDefaults.standard.set("", forKey: "loggedInUsername")
                UserDefaults.standard.set("", forKey: "loggedInUserDisplayName")
                UserDefaults.standard.set(false, forKey: "userExists")
                moveToAuthView.toggle()
            }, label: {
                Text("Logout")
                    .font(.title2)
                    .bold()
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(12)
                    .padding()
            })
            Spacer()
        }
        .onAppear() {
            searchUser()
        }
    }
    
    func searchUser() {
        for user in users {
            print("Old username - " + (user.username?.lowercased() ?? "empty"))
            print("entered - " + (user.username?.lowercased() ?? "empty"))
            if let oldUsername = user.username {
                if oldUsername.lowercased() == username!.lowercased() {
                    displayName = "yes"
                    displayName = user.displayName
                    break
                }
            }
        }
    }
    
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
