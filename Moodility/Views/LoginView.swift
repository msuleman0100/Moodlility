//
//  AuthView.swift
//  Moodility
//
//  Created by Muhammad Suleman on 4/23/23.
//

import SwiftUI

struct LoginView: View {
    
    @State var username = ""
    @FetchRequest(sortDescriptors: []) private var users: FetchedResults<User>
    @State var userFound = false
    @State var moveToTabsView = false
    
    var body: some View {
            VStack(alignment: .leading, spacing: 16) {
                
                Text("Find your stats by typing your username below..")
                    .padding(.horizontal)
                    .font(.title3)
                    .fontWeight(.medium)
                
                Spacer()
                
                Text("Username")
                    .font(.title2)
                    .bold()
                    .foregroundColor(Color.white)
                    .padding(.horizontal)
                    .padding(.top, 32)
                TextField("e.g. msuleman0100", text: $username)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .padding(.horizontal)
                    .foregroundColor(.black)
               
                NavigationLink("", destination: TabsView()
                    .navigationBarBackButtonHidden(true),
                               isActive: $moveToTabsView)
               
                Button {
                    UserDefaults.standard.set(username, forKey: "loggedInUsername")
                    UserDefaults.standard.set(true, forKey: "userExists")
                    let username = UserDefaults.standard.string(forKey: "loggedInUsername")
                    print("\nCurrent username - \(username ?? "ooo"))")
                    moveToTabsView.toggle()
                } label: {
                    Text("Continue")
                        .font(.title2)
                        .bold()
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(12)
                        .padding()
                }
                .opacity(userFound ? 1:0.5)
                .disabled(userFound ? false:true)
                
                NavigationLink { RegisterView() } label: {
                    HStack {
                        Spacer()
                            Text("Don't have an accoount?  ")
                            +
                            Text("Register Now")
                                .font(.title3)
                                .underline()
                        Spacer()
                    }
                    .padding(.bottom, 32)
                }

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.orange)
            .foregroundColor(.white)
            .onChange(of: username) { _ in
                searchUser()
            }
            .navigationTitle("Login")
    }
    
    func searchUser() {
        for user in users {
            print("Old username - " + (user.username?.lowercased() ?? "empty"))
            print("entered - " + (user.username?.lowercased() ?? "empty"))
            if let oldUsername = user.username {
                if oldUsername.lowercased() == username.lowercased() {
                    withAnimation { userFound = true}
                    print("\nTrued...")
                    break
                }  else {
                    withAnimation { userFound = false }
                }
            }
        }
    }
    
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
