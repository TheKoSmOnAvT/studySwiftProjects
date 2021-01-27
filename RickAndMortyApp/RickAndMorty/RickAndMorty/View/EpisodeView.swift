//
//  EpisodeView.swift
//  RickAndMorty
//
//  Created by Никита Попов on 27.01.2021.
//

import SwiftUI

struct EpisodeView: View {
    var episode : ResultEpisodeModel
    
    var body: some View {
        
        HStack(alignment: .center) {
            Text(self.episode.name ??  "unknow").font(.system(.title2))
                .bold()
                .padding()
        }
        HorizontalTextView(title: "Type: ", data: self.episode.airDate ??  "unknow")
        HorizontalTextView(title: "Dimension: ", data: self.episode.episode  ??  "unknow", grayBackground : true)
        HorizontalTextView(title: "Created: ", data: self.episode.created ?? "unknow")
        
        ForEach(self.episode.characters.map{ String($0!)}, id: \.self){ resident in
            //TO DO: character View
            Text(resident)
        }
        Spacer()
    }
}

