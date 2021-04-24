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
    var body: some Scene {
        WindowGroup {
            TabView {
                NoteListView()
                 .tabItem {
                    Image(systemName: "highlighter")
                    Text("Заметки")
                  }
                AccountView(fb: fb).tabItem {
                    Image(systemName: "person.circle")
                    Text("Аккаунт")
                }
            }
        }
    }
}
