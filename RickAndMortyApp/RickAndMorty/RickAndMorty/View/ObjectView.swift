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
        VStack{
            Group {
                Text(objectModel.character?.info?.next ?? "123" )
                Text(objectModel.character?.info?.prev ?? "123")
            }
        }.onAppear {
            self.objectModel.fetchCharacters()
        }
    }
}

//struct ObjectView_Previews: PreviewProvider {
//    static var previews: some View {
//        ObjectView(ObjectViewModel())
//    }
//}
