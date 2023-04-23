//
//  AuthView.swift
//  Moodility
//
//  Created by Muhammad Suleman on 4/23/23.
//

import SwiftUI

struct AuthView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Modility")
                .font(.largeTitle)
                .fontWeight(.black)
                .padding([.top, .leading, .trailing])
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
            TextField("e.g. msuleman0100", text: .constant(""))
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
            Spacer()
            Spacer()
            Text("Continue")
                .font(.title2)
                .bold()
                .padding()
                .frame(maxWidth: .infinity, maxHeight: 50)
                .background(Color.blue)
                .foregroundColor(Color.white)
                .cornerRadius(12)
                .padding()
                .opacity(0.5)
            Text("Register")
                .font(.title2)
                .bold()
                .padding()
                .frame(maxWidth: .infinity, maxHeight: 50)
                .background(Color.blue)
                .foregroundColor(Color.white)
                .cornerRadius(12)
                .padding()
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.orange)
        .foregroundColor(.white)
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
