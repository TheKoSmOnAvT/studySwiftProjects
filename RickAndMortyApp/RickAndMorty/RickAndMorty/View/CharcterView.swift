//
//  CharcterView.swift
//  RickAndMorty
//
//  Created by Никита Попов on 15.01.2021.
//

import SwiftUI

struct CharcterView: View {
    var character : ResultCharaterModel?
    @ObservedObject var imageLoader = UIImageLoader()
    @ObservedObject var characterLoader = CharacterLoader()
    
    var body: some View {
        if(characterLoader.character != nil) {
            ScrollView(.vertical) {
            VStack {
                Image(uiImage:  self.imageLoader.image!)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 4))
                    .padding()
                HorizontalTextView(title: "Name:", data: characterLoader.character!.name)
                HorizontalTextView(title: "Gender:", data: characterLoader.character!.gender , grayBackground: true)
                HorizontalTextView(title: "Created:", data: characterLoader.character!.created)
                HorizontalTextView(title: "Species:", data: characterLoader.character!.species, grayBackground: true)
                HorizontalTextView(title: "Status:", data: characterLoader.character!.status)
                HorizontalTextView(title: "Type:", data: characterLoader.character!.type, grayBackground: true)
                HorizontalTextView(title: "Location:", data: characterLoader.character!.location.name)
                
                HStack(alignment: .center) {
                    ForEach(characterLoader.character!.episodesURLToInt.map{ String($0)}, id: \.self) { episode in
                            Text(episode).padding()
                    }
                }
                }.navigationBarTitle(characterLoader.character!.name)
                .onAppear {
                    self.imageLoader.fetchImage(url: self.characterLoader.character!.image)
                }
            }
        } else if ( self.character != nil) {
            ScrollView(.vertical) {
            VStack {
                Image(uiImage:  self.imageLoader.image!)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 4))
                    .padding()
                HorizontalTextView(title: "Name:", data: character!.name)
                HorizontalTextView(title: "Gender:", data: character!.gender , grayBackground: true)
                HorizontalTextView(title: "Created:", data: character!.created)
                HorizontalTextView(title: "Species:", data: character!.species, grayBackground: true)
                HorizontalTextView(title: "Status:", data: character!.status)
                HorizontalTextView(title: "Type:", data: character!.type, grayBackground: true)
                HorizontalTextView(title: "Location:", data: character!.location.name) // TO DO: - button to view location
                 // TO DO: - button to view location
                HStack(alignment: .center) {
                    ForEach(character!.episodesURLToInt.map{ String($0)}, id: \.self) { episode in
                            Text(episode).padding()
                    }
                }
                }.navigationBarTitle(character!.name)
                .onAppear {
                    self.imageLoader.fetchImage(url: self.character!.image)
                }
            }
        } else {
            LoaderView()
        }
    }
}


 

//struct CharcterView_Previews: PreviewProvider {
//    static var previews: some View {
//        CharcterView()
//    }
//}
