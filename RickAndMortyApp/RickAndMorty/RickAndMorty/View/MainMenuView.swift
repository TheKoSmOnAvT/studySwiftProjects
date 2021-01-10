//
//  ContentView.swift
//  RickAndMorty
//
//  Created by Никита Попов on 10.01.2021.
//

import SwiftUI

   struct MainMenuView: View {
    @ObservedObject var mainMenu = MainMenuViewModel()
    @State private var editMode : EditMode = .inactive
    var body: some View {
        NavigationView {
            List {
                ForEach(mainMenu.objectsURL){ object in
                    NavigationLink( destination: ObjectView(objectModel: ObjectViewModel())) {
                            Text(object.title ?? "")
                        }
                }
            }
            .navigationBarTitle("Main Menu")
        }
        
    }
    
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainMenuView()
//    }
//}
//.navigationBarItems(
//        leading: Button("Refresh", action: {self.mainMenu.fetchURL()})
//    )