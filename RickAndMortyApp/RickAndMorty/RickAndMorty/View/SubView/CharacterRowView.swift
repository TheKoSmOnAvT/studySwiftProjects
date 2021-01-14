//
//  CharacterRowView.swift
//  RickAndMorty
//
//  Created by Никита Попов on 14.01.2021.
//

import SwiftUI

struct CharacterRowView: View {
    @State private var sizeImage : CGFloat = 100
    
    
    var result : Result
    @ObservedObject var imageLoader = UIImageLoader()
    var body: some View {
        HStack {
            if(self.imageLoader.image != nil) {
                Image( uiImage: self.imageLoader.image!).resizable().frame(width: self.sizeImage, height: self.sizeImage)
            } else {
                Image(systemName: "person.fill.questionmark").resizable().frame(width: self.sizeImage, height: self.sizeImage)
            }
            Text(self.result.name)
        }.onAppear {
            self.imageLoader.fetchImage(url: self.result.image)
        }
    }
}

//struct CharacterRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        CharacterRowView()
//    }
//}
