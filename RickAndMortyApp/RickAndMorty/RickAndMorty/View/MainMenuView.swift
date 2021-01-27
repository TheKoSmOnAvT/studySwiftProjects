//
//  ContentView.swift
//  RickAndMorty
//
//  Created by Никита Попов on 10.01.2021.
//

import SwiftUI

   struct MainMenuView: View {
    @ObservedObject var mainMenu = MainMenuViewModel()
    
    var body: some View {
        NavigationView {
            List(mainMenu.objectsURL){ object in
                    NavigationLink( destination: ObjectView(objectModel: ObjectViewModel(mainMenuObject: object))) {
                            Text(object.title ?? "")
                        }
            }.navigationBarTitle("Main Menu", displayMode: .inline)
        }
    }
   }
