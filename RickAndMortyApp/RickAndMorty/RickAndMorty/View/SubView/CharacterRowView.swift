//
//  CharacterRowView.swift
//  RickAndMorty
//
//  Created by Никита Попов on 14.01.2021.
//

import SwiftUI

struct CharacterRowView: View {
    @State private var sizeImage : CGFloat = 100
    var result : ResultCharaterModel?
    
    @ObservedObject var characterLoader = CharacterLoader()
    @ObservedObject var imageLoader = UIImageLoader()
    
    var body: some View {
        if (characterLoader.character != nil) {
            HStack{
                Image( uiImage: (self.imageLoader.image ??  UIImage(systemName: "person.fill.questionmark"))! ).resizable().frame(width: self.sizeImage, height: self.sizeImage)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.black, lineWidth: roundWidthLine))
                    .padding()
                Text(self.characterLoader.character!.name  ?? "unknow").font(.system(size: textSize))
                    .padding()
                Spacer()
            }.onAppear {
                self.imageLoader.fetchImage(url: self.characterLoader.character!.image ?? "")
            }
        } else if (result != nil) {
            HStack{
                Image( uiImage: self.imageLoader.image!).resizable().frame(width: self.sizeImage, height: self.sizeImage)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.black, lineWidth: roundWidthLine))
                    .padding()
                Text(self.result!.name ?? "unknow").font(.system(size: textSize))
                    .padding()
                Spacer()
            }.onAppear {
                self.imageLoader.fetchImage(url: self.result!.image ?? "unknow")
            }
        }
//        else {
//            LoaderView()
//        }
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
