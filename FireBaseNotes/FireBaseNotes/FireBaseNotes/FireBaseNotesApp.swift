//
//  FireBaseNotesApp.swift
//  FireBaseNotes
//
//  Created by Никита Попов on 07.02.2021.
//

import SwiftUI
import Firebase

@main
struct FireBaseNotesApp: App {
    private var fb : FireBase = FireBase()
    @ObservedObject var cd = CoreData()
//
//    init() {
//        Sync()
//    }
//
//    mutating func Sync(){
//        var FB =  self.fb
//        DispatchQueue.global(qos: .background).async {
//            FB.SyncData()
//           }
//    }
    
    
    var body: some Scene {
        WindowGroup {
            TabView {
                //NoteListView(fb: fb)
                NoteListView(cd: cd)
                    .tabItem {
                        Image(systemName: "highlighter")
                        Text("Заметки")
                  }
                AccountView(fb: fb, cd: cd)
                    .tabItem {
                        Image(systemName: "person.circle")
                        Text("Аккаунт")
                }
            }.accentColor(.pink)
            
        }
    }
}
