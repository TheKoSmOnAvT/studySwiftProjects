//
//  AccountView.swift
//  FireBaseNotes
//
//  Created by Никита Попов on 29.03.2021.
//

import SwiftUI

struct AccountView: View {
    @ObservedObject var fb : FireBase
    @ObservedObject var cd = CoreData()
    
    @State private var showLogin = false
    @State private var showRegistration = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 10) {
                Spacer()
                if(!self.fb.notLoginStatus) {
                    Text("You are logged in")
                    Button(action: {
                        self.fb.logout()
                    }) {
                        Text("Log out")
                            .padding()
                            .foregroundColor(.black)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 2)
                            )
                    }
                    
                    Button(action: {
                        self.fb.SyncData()
                        self.cd.GetNotes()
                    }) {
                        Text("Sync")
                            .padding()
                            .foregroundColor(.black)
                            .background(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 2)
                            )
                    }
                    
                } else {
                    Button("Login") {
                        self.showLogin.toggle()
                    }.sheet(isPresented: self.$showLogin) {
                        LoginView(showModal: self.$showLogin, fb: fb)
                    }.padding(.top, 50)
     
                    
                    Button("Registration") {
                        self.showRegistration.toggle()
                    }.sheet(isPresented: self.$showRegistration) {
                        RegistrationView(showModal: self.$showRegistration,fb : self.fb)
                    }.padding(.top, 50)
                }
                Spacer()
            }
        }
    }
}

//struct AccountView_Previews: PreviewProvider {
//    static var previews: some View {
//        AccountView()
//    }
//}
