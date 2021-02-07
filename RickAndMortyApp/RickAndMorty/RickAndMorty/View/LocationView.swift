//
//  LocationView.swift
//  RickAndMorty
//
//  Created by Никита Попов on 24.01.2021.
//

import SwiftUI

struct LocationView: View {
    var location : ResultLocationModel?
    
    var body: some View {
        if  (self.location != nil) {
            ScrollView(.vertical) {
                VStack{
                    HStack(alignment: .center) {
                        Text(self.location!.name).font(.system(.title2))
                            .bold()
                            .padding()
                    }
                    HorizontalTextView(title: "Type: ", data: self.location!.type)
                    HorizontalTextView(title: "Dimension: ", data: self.location!.dimension, grayBackground : true)
                    HorizontalTextView(title: "Created: ", data: self.location!.created?.formatDate  ?? "unknow")
                    
                    HStack(alignment: .center) {
                        Text("Residents").font(.system(.title2))
                            .bold()
                            .padding()
                    }
                    
                    ForEach(self.location!.residents.map{ String($0)}, id: \.self) { resident in
                            NavigationLink(destination: CharcterView(characterLoader: CharacterLoader(url: resident)))  {
                                CharacterRowView(characterLoader: CharacterLoader(url: resident))
                            }
                        }
                }
            }
        } else {
            LoaderView()
        }
    }
}


