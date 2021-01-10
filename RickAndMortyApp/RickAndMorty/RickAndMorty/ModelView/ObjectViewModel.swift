//
//  ObjectViewModel.swift
//  RickAndMorty
//
//  Created by Никита Попов on 10.01.2021.
//

import Foundation

public class ObjectViewModel : ObservableObject {
    @Published var character : CharaterRequestModel?
    init(){
    }
    public func fetchCharacters(page : Int = 1) -> Void {
        let url =  "https://rickandmortyapi.com/api/character/?page=\(page)"
        if let url = URL(string: url){
            URLSession.shared.dataTask(with: url) { data, res, error in
                if let data = data {
                    DispatchQueue.main.async {
                        let decoder = JSONDecoder()
                        if let json = try? decoder.decode(CharaterRequestModel.self, from: data){
                            print(json)
                            print(123)
                            self.character =  json
                        }
                        else  {
                            print("error json")
                        }
                    }
                }
            }.resume()
            
        } else {
            print("error")
        }
    }
}
