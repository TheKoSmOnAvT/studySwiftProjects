//
//  LoginView.swift
//  FireBaseNotes
//
//  Created by Никита Попов on 09.02.2021.
//

import SwiftUI

struct LoginView: View {
    @State var mail : String = ""
    @State var password : String = ""
    var body: some View {
        VStack {
            NavigationView {
                Form {
                    TextField("Mail", text: $mail)
                    TextField("Password", text: $password)
                }.navigationTitle("Authorization")
            }
            Button(action: {
                print("123")
            }, label: {
                HStack {
                    Text("Login").font(.headline)
                }
            })
        Spacer()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
