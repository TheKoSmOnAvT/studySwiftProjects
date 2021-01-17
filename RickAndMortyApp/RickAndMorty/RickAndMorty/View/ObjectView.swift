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
                if(objectModel.character != nil) {
                    List(objectModel.character!.results) { result in
                        NavigationLink(destination: CharcterView(character: result) ){
                            CharacterRowView(result: result).navigationBarTitle("Characters", displayMode: .inline)
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
