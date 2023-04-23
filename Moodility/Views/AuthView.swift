//
//  AuthView.swift
//  Moodility
//
//  Created by Muhammad Suleman on 4/23/23.
//

import SwiftUI

struct AuthView: View {
    
    @State var username = ""
    @FetchRequest(sortDescriptors: []) private var users: FetchedResults<User>
    @State var userFound = false
    @State var moveToTabsView = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 16) {
                
                Text("Find your existing user name or signuo if you don't have account.")
                    .padding(.horizontal)
                    .font(.title3)
                    .fontWeight(.medium)
                
                Text("Usernaame")
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
                
                Spacer()
                Spacer()
                NavigationLink("", destination: TabsView()
                    .navigationBarBackButtonHidden(true),
                               isActive: $moveToTabsView)
                Text(moveToTabsView.description)
                
                Button {
                    UserDefaults.standard.set(username, forKey: "loggedInUsername")
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
                
              
                
                Button(action: {
                    
                }, label: {
                    Text("Register")
                        .font(.title2)
                        .bold()
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(12)
                        .padding()
                })
                .opacity(username.isEmpty ? 0.5:1)
                .disabled(username.isEmpty ? true:false)
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.orange)
            .foregroundColor(.white)
            .onChange(of: username) { _ in
                searchUser()
            }
            .navigationTitle("Moodility")
        }
    }
    
    func searchUser() {
        for user in users {
            if let oldUsername = user.username {
                if oldUsername.lowercased() == username.lowercased() {
                    withAnimation { userFound = true }
                    print("\nTrued...")
                }  else {
                    withAnimation { userFound = false }
                }
            }
        }
    }
    
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
