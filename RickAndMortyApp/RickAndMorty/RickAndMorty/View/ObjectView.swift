//
//  ObjectView.swift
//  RickAndMorty
//
//  Created by Никита Попов on 10.01.2021.
//

import SwiftUI

struct ObjectView: View {
    @ObservedObject var objectModel : ObjectViewModel
    var body: some View {
        VStack {
            if(objectModel.character != nil) {
                List {
                    ForEach(objectModel.character!.results){ result in
                        //NavigationLink( destination: Text("character info there")) {
                            //Text("123")
                        CharacterRowView(result: result)
                        //}
                    }
                }
            } else {
                Text("empty url")
            }
        }.onAppear {
            self.objectModel.fetchData()
        }
    }
}

//struct ObjectView_Previews: PreviewProvider {
//    static var previews: some View {
//        ObjectView(ObjectViewModel())
//    }
//}
