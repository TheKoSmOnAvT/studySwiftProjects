//
//  RegistrationView.swift
//  FireBaseNotes
//
//  Created by Никита Попов on 09.02.2021.
//

import SwiftUI

struct RegistrationView: View {
    @State var mail : String = ""
    @State var password : String = ""
    var fb :  FireBase
    var body: some View {
        VStack {
            NavigationView {
                Form {
                    TextField("Mail", text: $mail)
                    TextField("Password", text: $password)
                }.navigationTitle("Registration")
            }
            Button(action: {
                fb.registration(mail: self.mail, password: self.password)
            }, label: {
                HStack {
                    Text("Create account").font(.headline)
                }
            }).padding()
        Spacer()
        }
    }
}

//struct RegistrationView_Previews: PreviewProvider {
//    static var previews: some View {
//        RegistrationView()
//    }
//}
