//
//  LocationRowView.swift
//  RickAndMorty
//
//  Created by Никита Попов on 31.01.2021.
//

import SwiftUI

struct EpisodeRowView: View {
    @State private var textSize : CGFloat = 20
    @ObservedObject var episodeLoader = EpisodeLoader()
    
    var body: some View { if (episodeLoader.episode != nil) {
        HStack {
            Text(self.episodeLoader.episode?.name  ?? "unknow").font(.system(size: textSize))
                .padding()
        }
    }
    }
}


