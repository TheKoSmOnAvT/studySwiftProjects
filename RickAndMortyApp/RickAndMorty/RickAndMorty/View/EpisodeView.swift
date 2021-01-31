//
//  EpisodeView.swift
//  RickAndMorty
//
//  Created by Никита Попов on 27.01.2021.
//

import SwiftUI

struct EpisodeView: View {
    var episode : ResultEpisodeModel?
    var episodeLoader =  EpisodeLoader()
    
    var body: some View {
        if  (self.episode != nil)  {
            ScrollView(.vertical) {
            HStack(alignment: .center) {
                Text(self.episode!.name ??  "unknow").font(.system(.title2))
                    .bold()
                    .padding()
            }
            HorizontalTextView(title: "Type: ", data: self.episode!.airDate ??  "unknow")
            HorizontalTextView(title: "Dimension: ", data: self.episode!.episode  ??  "unknow", grayBackground : true)
            HorizontalTextView(title: "Created: ", data: self.episode!.created ?? "unknow")
                
            HStack(alignment: .center) {
                Text("Characters:").font(.system(.title2))
                    .bold()
                    .padding()
            }
                
            ForEach(self.episode!.characters.map{ String($0!)}, id: \.self) { resident in
                    NavigationLink(destination: CharcterView(characterLoader: CharacterLoader(url: resident)))  {
                        CharacterRowView(characterLoader: CharacterLoader(url: resident))
                    }
                }
            }
        }  else if (self.episodeLoader.episode  != nil){
            ScrollView(.vertical) {
            HStack(alignment: .center) {
                Text(self.episodeLoader.episode?.name ??  "unknow").font(.system(.title2))
                    .bold()
                    .padding()
            }
            HorizontalTextView(title: "Type: ", data: self.episodeLoader.episode!.airDate ??  "unknow")
            HorizontalTextView(title: "Dimension: ", data: self.episodeLoader.episode!.episode  ??  "unknow", grayBackground : true)
            HorizontalTextView(title: "Created: ", data: self.episodeLoader.episode!.created ?? "unknow")
                
            HStack(alignment: .center) {
                Text("Characters:").font(.system(.title2))
                    .bold()
                    .padding()
            }
                
            ForEach(self.episodeLoader.episode!.characters.map{ String($0!)}, id: \.self) { resident in
                    NavigationLink(destination: CharcterView(characterLoader: CharacterLoader(url: resident)))  {
                        CharacterRowView(characterLoader: CharacterLoader(url: resident))
                    }
                }
            }

        }
        
    }
}

