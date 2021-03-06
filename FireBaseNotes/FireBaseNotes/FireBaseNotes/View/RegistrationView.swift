//
//  RegistrationView.swift
//  FireBaseNotes
//
//  Created by Никита Попов on 09.02.2021.
//

import SwiftUI

struct RegistrationView: View {
    @Environment(\.presentationMode) var presentation
    
    @State var mail : String = ""
    @State var password : String = ""
    @ObservedObject var fb :  FireBase
    var body: some View {
        ScrollView(.vertical){
            Spacer()
            VStack(alignment: .center, spacing : 15) {
                Spacer()
                Text("Registration")
                    .font(.custom("Helvetica Neue", size: 28))
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
                    .padding()
                VStack(alignment: .leading, spacing : 15) {
                        TextField("Mail", text: $mail)
                            .font(.headline)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(20.0)
                            .shadow(radius: 10.0, x: 20, y: 10)
                            .padding()
                        SecureField("Password", text: $password)
                            .font(.headline)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(20.0)
                            .shadow(radius: 10.0, x: 20, y: 10)
                            .padding()
                }
                Button(action: {
                   _ =  fb.registration(mail: self.mail, password: self.password)
                    self.presentation.wrappedValue.dismiss()
                }, label: {
                        Text("Create account")
                            .font(.headline)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(20.0)
                }).padding()
            Spacer()
            }
            Spacer()
        }.background(
            LinearGradient(gradient: Gradient(colors: [ .white,.red,.white]), startPoint: .top, endPoint: .bottom)
        ).ignoresSafeArea()
    }
}

//struct RegistrationView_Previews: PreviewProvider {
//    static var previews: some View {
//        RegistrationView()
//    }
//}
