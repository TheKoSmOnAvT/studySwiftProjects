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
    var fb :  FireBase
    var body: some View {
        VStack {
            NavigationView {
                Form {
                    TextField("Mail", text: $mail)
                    TextField("Password", text: $password)
                }.navigationTitle("Authorization")
            }
            Button(action: {
                self.fb.login(mail: self.mail, password: self.password)
            }, label: {
                HStack {
                    Text("Login").font(.headline)
                }
            })
        Spacer()
        }
    }
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}
