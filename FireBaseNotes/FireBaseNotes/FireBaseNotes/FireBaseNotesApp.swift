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
    @ObservedObject var cd = CoreData()
    var body: some Scene {
        WindowGroup {
            TabView {
                NoteListView(cd: cd)
                    .onAppear {
                        self.cd.GetNotes()
                }
                    .tabItem {
                        Image(systemName: "highlighter")
                        Text("Заметки")
                  }
                AccountView(cd: cd)
                    .tabItem {
                        Image(systemName: "person.circle")
                        Text("Аккаунт")
                }
            }.accentColor(.pink)
            .onAppear{
                self.cd.GetNotesStatus()
            }
            
        }
    }
}
