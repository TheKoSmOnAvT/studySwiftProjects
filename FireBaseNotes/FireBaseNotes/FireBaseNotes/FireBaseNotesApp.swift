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
    var body: some Scene {
        WindowGroup {
            //RegistrationView(fb: FireBase())
            LoginView(fb: FireBase())
        }
    }
}

