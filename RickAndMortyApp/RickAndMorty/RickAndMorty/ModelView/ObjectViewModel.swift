//
//  ObjectViewModel.swift
//  RickAndMorty
//
//  Created by Никита Попов on 10.01.2021.
//

import Foundation

public class ObjectViewModel : ObservableObject {
    @Published var character : CharaterRequestModel?
    private var object : MainMenuModel
    
    var testStringInfo: String? {
        self.character?.results.first?.gender
    }
    
    
    init(mainMenuObject : MainMenuModel){
        self.object = mainMenuObject
    }
    
    public func fetchData(page : Int = 1) -> Void {
        let url =  "\(object.url!)/?page=\(page)"
        if let url = URL(string: url) {
            URLSession.shared.dataTask(with: url) { data, res, error in
                if let data = data {
                    self.convertObjectToModel(data: data)
                }
            }.resume()
        } else {
            print("error")
        }
    }


    public func convertObjectToModel(data : Data) -> Void {
        if let titleObject = self.object.title {
            switch titleObject {
                case "characters":
                    convertCharacter(data: data)
                default:
                    return
            }
        }
    }

    public func convertCharacter(data : Data) -> Void {
        DispatchQueue.main.async(qos : .background){
            let decoder = JSONDecoder()
            print("1234")
            if let json = try? decoder.decode(CharaterRequestModel.self, from: data){
                self.character =  json
            }
            else  {
                print("error json")
            }
        }
    }
}
