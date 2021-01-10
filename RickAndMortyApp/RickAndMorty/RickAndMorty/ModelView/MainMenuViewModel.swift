//
//  MainMenuViewModel.swift
//  RickAndMorty
//
//  Created by Никита Попов on 10.01.2021.
//

import Foundation

public class MainMenuViewModel : ObservableObject {
    @Published public var objectsURL : [MainMenuModel]
    
    init() {
        objectsURL = []
        fetchURL()
    }
    
    public func fetchURL() -> Void {
        let url =  "https://rickandmortyapi.com/api"
        if let url = URL(string: url){
            URLSession.shared.dataTask(with: url) { data, res, error in
                if let data = data {
                    DispatchQueue.main.async {
                        let decoder = JSONDecoder()
                        if let json = try? decoder.decode(Dictionary<String,String>.self, from: data){
                            for item in json {
                                self.objectsURL.append(MainMenuModel(url: item.value, title: item.key))
                            }
                        }
                    }
                }
            }.resume()
            
        } else {
            print("error")
        }
    }
}


