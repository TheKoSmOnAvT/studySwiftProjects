//
//  CharacterRowView.swift
//  RickAndMorty
//
//  Created by Никита Попов on 14.01.2021.
//

import SwiftUI

struct CharacterRowView: View {
    @State private var sizeImage : CGFloat = 100
    var result : ResultCharaterModel
    
    @ObservedObject var imageLoader = UIImageLoader()
    var body: some View {
        HStack{
            Image( uiImage: self.imageLoader.image!).resizable().frame(width: self.sizeImage, height: self.sizeImage)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.black, lineWidth: roundWidthLine))
                .padding()
            Text(self.result.name).font(.system(size: textSize))
                .padding()
            Spacer()
        }.onAppear {
            self.imageLoader.fetchImage(url: self.result.image)
        }
    }
    //MARK: - interface const
    @State private var textSize : CGFloat = 20
    @State private var roundWidthLine : CGFloat = 5
}

//struct CharacterRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        CharacterRowView()
//    }
//}
