//
//  CharcterView.swift
//  RickAndMorty
//
//  Created by Никита Попов on 15.01.2021.
//

import SwiftUI

struct CharcterView: View {
    var character : Result
    @ObservedObject var imageLoader = UIImageLoader()
    var body: some View {
        ScrollView(.vertical) {
        VStack {
            Image(uiImage:  self.imageLoader.image!)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray, lineWidth: 4))
                .padding()
            CharacterHorizontalTextView(title: "Name:", data: character.name)
            CharacterHorizontalTextView(title: "Gender:", data: character.gender , grayBackground: true)
            CharacterHorizontalTextView(title: "Created:", data: character.created)
            CharacterHorizontalTextView(title: "Species:", data: character.species, grayBackground: true)
            CharacterHorizontalTextView(title: "Status:", data: character.status)
            CharacterHorizontalTextView(title: "Type:", data: character.type, grayBackground: true)
            CharacterHorizontalTextView(title: "Location:", data: character.location.name) // TO DO: - button to view location
             // TO DO: - button to view location
            HStack(alignment: .center) {
                ForEach(character.episodesURLToInt.map{ String($0)}, id: \.self) { episode in
                        Text(episode).padding()
                }
            }
        }.navigationBarTitle(character.name)
        .onAppear {
            self.imageLoader.fetchImage(url: self.character.image)
        }
        }
    }
}


 

//struct CharcterView_Previews: PreviewProvider {
//    static var previews: some View {
//        CharcterView()
//    }
//}
