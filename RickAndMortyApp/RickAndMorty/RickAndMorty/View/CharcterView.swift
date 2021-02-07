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
        if(self.characterLoader.character != nil) {
            ScrollView(.vertical) {
            VStack {
                Image(uiImage:  self.imageLoader.image!)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 4))
                    .padding()
                HorizontalTextView(title: "Name:", data: (self.characterLoader.character!.name ??  "unknow"))
                HorizontalTextView(title: "Gender:", data: self.characterLoader.character!.gender ?? "unknow" , grayBackground: true)
                HorizontalTextView(title: "Created:", data: self.characterLoader.character!.created?.formatDate ?? "unknow")
                HorizontalTextView(title: "Species:", data: self.characterLoader.character!.species ?? "unknow", grayBackground: true)
                HorizontalTextView(title: "Status:", data: self.characterLoader.character!.status ?? "unknow")
                HorizontalTextView(title: "Type:", data: self.characterLoader.character!.type ?? "unknow", grayBackground: true)
                HorizontalTextView(title: "Location:", data: self.characterLoader.character!.location?.name ?? "unknow")
                
                HStack(alignment: .center) {
                    Text("Episodes").font(.system(.title2))
                        .bold()
                        .padding()
                }
                VStack(alignment: .leading){
                    ForEach(self.characterLoader.character!.episode.map{ String($0!)}, id: \.self) { episode in
                        NavigationLink(destination: EpisodeView(episodeLoader: EpisodeLoader(url: episode)))  {
                            EpisodeRowView(episodeLoader: EpisodeLoader(url: episode))
                        }
                    }
                }
                }
                .navigationBarTitle(self.characterLoader.character!.name ?? "unknow")
                .onAppear {
                    self.imageLoader.fetchImage(url: self.characterLoader.character!.image ?? "")
                }
            }
        } else if ( self.character != nil) {
            ScrollView(.vertical) {
            VStack {
                Image(uiImage:  self.imageLoader.image!)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 4))
                    .padding()
                HorizontalTextView(title: "Name:", data: self.character!.name ?? "unknow")
                HorizontalTextView(title: "Gender:", data: self.character!.gender ?? "unknow", grayBackground: true)
                HorizontalTextView(title: "Created:", data: self.character!.created?.formatDate  ?? "unknow")
                HorizontalTextView(title: "Species:", data: self.character!.species ?? "unknow", grayBackground: true)
                HorizontalTextView(title: "Status:", data: self.character!.status ?? "unknow")
                HorizontalTextView(title: "Type:", data: self.character!.type ?? "unknow", grayBackground: true)
                HorizontalTextView(title: "Location:", data: self.character!.location?.name ?? "unknow")
               
                HStack(alignment: .center) {
                    Text("Episodes").font(.system(.title2))
                        .bold()
                        .padding()
                }
                VStack(alignment: .leading){
                    ForEach(self.character!.episode.map{ String($0!)}, id: \.self) { episode in
                        NavigationLink(destination: EpisodeView(episodeLoader: EpisodeLoader(url: episode)))  {
                            EpisodeRowView(episodeLoader: EpisodeLoader(url: episode))
                        }
                    }
                }
            }.navigationBarTitle(self.character!.name ?? "unknow")
                .onAppear {
                    self.imageLoader.fetchImage(url: self.character!.image ?? "")
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
