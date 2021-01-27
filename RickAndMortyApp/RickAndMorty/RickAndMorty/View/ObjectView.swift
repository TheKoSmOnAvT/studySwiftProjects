//
//  ObjectView.swift
//  RickAndMorty
//
//  Created by Никита Попов on 10.01.2021.
//

import SwiftUI

struct ObjectView: View {
    @ObservedObject var objectModel : ObjectViewModel
    var body: some View {
        VStack{
                if(objectModel.character != nil) {
                    List(objectModel.character!.results) { result in
                        NavigationLink(destination: CharcterView(character: result) ){
                            CharacterRowView(result: result).navigationBarTitle("Characters", displayMode: .inline)
                                .onAppear{
                                    self.objectModel.checkCharacterId(resultId: result.id)
                            }
                        }
                    }
                } else if (objectModel.location != nil) {
                    List(objectModel.location!.results) { result in
                        NavigationLink(destination: LocationView(location: result)) {
                            Text(result.name).navigationBarTitle("Locations", displayMode: .inline)
                                .onAppear{
                                    self.objectModel.checkLocationId(resultId: result.id)
                                }
                        }
                    }
                } else if  (objectModel.episode != nil)  {
                    List(objectModel.episode!.results)  { result in 
                        NavigationLink(destination: EpisodeView(episode :  result))  {
                            Text(result.name  ??  "empty").navigationBarTitle("Episodes",  displayMode:  .inline)
                                .onAppear  {
                                    self.objectModel.checkEpisodeId(resultId: result.id)
                                }
                        }
                    }
                } else {
                    LoaderView()
                }
        }.onAppear {
            self.objectModel.fetchData()
        }
    }
}
