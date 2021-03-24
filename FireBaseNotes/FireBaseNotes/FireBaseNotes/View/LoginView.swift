//
//  LoginView.swift
//  FireBaseNotes
//
//  Created by Никита Попов on 09.02.2021.
//

import SwiftUI

struct LoginView: View {
    @State private var mail : String = ""
    @State private var password : String = ""
    @ObservedObject private var fb :  FireBase = FireBase()
    private let width : CGFloat = 240.0
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            Image("ICON")
                .resizable()
                .frame(width: width, height: width*1.1)
                .colorInvert()
                
            
            VStack(alignment: .leading, spacing: 15) {
                        TextField("Mail", text: $mail)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(20.0)
                            .shadow(radius: 10.0, x: 20, y: 10)
                            .padding()
                        SecureField("Password", text: $password)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(20.0)
                            .shadow(radius: 10.0, x: 20, y: 10)
                            .padding()
            }
            Button(action: {
                self.fb.login(mail: self.mail, password: self.password)
            }, label: {
                    Text("Login")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.white)
                        .cornerRadius(15.0)
                        .shadow(radius: 10.0, x: 20, y: 10)
            }).padding(.top, 50)
        Spacer()
            //TO  DO: alert
        
//        .alert(isPresented: self.$fb.notLoginStatus ){ () -> Alert in
//           return Alert(title: Text("Incorrect login or password"))
//        }
        }.background(
            LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all))
    }
}


//struct AlertView: View {
//    
//    @State var showAlert = false
//    
//    var body: some View {
//        VStack {
//            Button(action: {
//                self.showAlert.toggle()
//            }) {
//                Text("Show alert!")
//            }
//        }.alert(isPresented: $showAlert) { () -> Alert in
//            Alert(title: Text("Hello World!"))
//        }
//    }
//    
//}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}
