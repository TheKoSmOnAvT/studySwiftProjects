//
//  LocationLoader.swift
//  RickAndMorty
//
//  Created by Никита Попов on 31.01.2021.
//

import Foundation

class EpisodeLoader : ObservableObject  {
    @Published var episode :  ResultEpisodeModel?
    
    init() {
    }
    
    init(url :  String) {
        if let url = URL(string: url) {
            URLSession.shared.dataTask(with: url) { data, res, error in
                if let data = data, error  ==  nil {
                    self.convertEpisode(data: data)
                }
            }.resume()
        } else {
            print("error")
        }
    }
    
    private func convertEpisode(data : Data) -> Void {
        DispatchQueue.main.async(qos : .background){
            let decoder = JSONDecoder()
            if let json = try? decoder.decode(ResultEpisodeModel.self, from: data){
                    self.episode = json
            }
            else  {
                print("error json")
            }
        }
    }
}
