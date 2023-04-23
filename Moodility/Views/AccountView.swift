//
//  AccountView.swift
//  Moodility
//
//  Created by Muhammad Suleman on 4/23/23.
//

import SwiftUI

struct AccountView: View {
    
    @State var moveToAuthView = false
    
    var body: some View {
    
            VStack(alignment: .leading) {
                Spacer()
                Text("Muhammad Suleman")
                    .padding(.horizontal)
                    .font(.largeTitle)
                    .fontWeight(.black)
                
                Text("msuleman0100")
                    .padding(.horizontal)
                    .padding(.top, 1)
                
                Spacer()
                Spacer()
                NavigationLink("", destination: AuthView()
                    .navigationBarBackButtonHidden(true),
                               isActive: $moveToAuthView)
                Button(action: {
                    UserDefaults.standard.set("", forKey: "loggedInUsername")
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
        
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
