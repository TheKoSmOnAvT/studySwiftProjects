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
    @State private var showLoading = false
    
    init(cd : CoreData){
        self.cd = cd
        self.fb = FireBase(db: cd)
    }
      
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 10) {
                Spacer()
                if(self.showLoading) {
                    ProgressView()
                }
                if(!self.fb.notLoginStatus) {
                    Text("You are logged in")
                    Button(action: {
                        self.fb.logout()
                      //  self.firstSyncAfterLoginStatus = false
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
                        self.showLoading = true
                        self.fb.SyncData(self.$showLoading)
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
                       // self.fb.SyncData(self.$showLoading)
                    }.sheet(isPresented: self.$showLogin) {
                        LoginView(showModal: self.$showLogin, fb: fb)
                    }.padding(.top, 50)
     
                    
                    Button("Registration") {
                        self.showRegistration.toggle()
                    }.sheet(isPresented: self.$showRegistration) {
                        RegistrationView(fb : self.fb)
                    }.padding(.top, 50)
                }
                Spacer()
            }
//            .onAppear{
//                if ( !self.firstSyncAfterLoginStatus && !self.fb.notLoginStatus) {
//                    self.showLoading = true
//                    self.fb.SyncData(self.$showLoading)
//                    self.firstSyncAfterLoginStatus = true
//                }
//            }
        }
    }
}

//struct AccountView_Previews: PreviewProvider {
//    static var previews: some View {
//        AccountView()
//    }
//}
