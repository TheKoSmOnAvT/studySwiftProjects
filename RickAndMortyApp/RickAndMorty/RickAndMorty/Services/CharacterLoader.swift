//
//  CharacterLoader.swift
//  RickAndMorty
//
//  Created by Никита Попов on 27.01.2021.
//

import Foundation


public  class CharacterLoader : ObservableObject {
    @Published var character : ResultCharaterModel?
    
    init() {
    }
    
    init(url :  String) {
        if let url = URL(string: url) {
            URLSession.shared.dataTask(with: url) { data, res, error in
                if let data = data, data !=  nil,  error  ==  nil {
                    self.convertCharacter(data: data)
                }
            }.resume()
        } else {
            print("error")
        }
    }
    
    private func convertCharacter(data : Data) -> Void {
        DispatchQueue.main.async(qos : .background){
            let decoder = JSONDecoder()
            if let json = try? decoder.decode(ResultCharaterModel.self, from: data){
                if self.character == nil  {
                    self.character = json
                }   
            }
            else  {
                print("error json")
            }
        }
    }
    
}
