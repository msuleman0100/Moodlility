//
//  RegisterView.swift
//  Moodility
//
//  Created by Muhammad Suleman on 4/23/23.
//

import SwiftUI

struct RegisterView: View {
    
    @State var displayName = ""
    @State var username = ""
    @State var moveToTabsView = false
    @Environment(\.presentationMode) var mode
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            Text("Register new account the required fields below.")
                .padding(.horizontal)
                .font(.title3)
                .fontWeight(.medium)
            
            Spacer()
            
            Text("Display Name")
                .font(.title2)
                .bold()
                .foregroundColor(Color.white)
                .padding(.horizontal)
                .padding(.top, 32)
            TextField("e.g. Muhammad Suleman", text: $displayName)
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .padding(.horizontal)
                .foregroundColor(.black)

            Text("Username")
                .font(.title2)
                .bold()
                .foregroundColor(Color.white)
                .padding(.horizontal)
                .padding(.top, 32)
            TextField("e.g. suleman0100", text: $username)
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
            .opacity(displayName.isEmpty ? 0.5: username.isEmpty ? 0.5:1)
            .disabled(displayName.isEmpty ? true: username.isEmpty ? true:false)
            
            Button {
                mode.wrappedValue.dismiss()
            } label: {
                HStack {
                    Spacer()
                        Text("Already have an accoount?  ")
                        +
                        Text("Login Now")
                            .font(.title3)
                            .underline()
                    Spacer()
                }
                .padding(.bottom, 32)
            }

            .navigationTitle("Register")

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.orange)
        .foregroundColor(.white)
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
