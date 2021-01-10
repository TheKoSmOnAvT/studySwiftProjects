//
//  RickAndMortyApp.swift
//  RickAndMorty
//
//  Created by Никита Попов on 10.01.2021.
//

import SwiftUI

@main
struct RickAndMortyApp: App {
    var body: some Scene {
        WindowGroup {
            MainMenuView(mainMenu: MainMenuViewModel())
        }
    }
}
