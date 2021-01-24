//
//  ObjectViewModel.swift
//  RickAndMorty
//
//  Created by Никита Попов on 10.01.2021.
//

import Foundation


public class ObjectViewModel : ObservableObject {
    
    @Published var character : CharaterModel?
    @Published var location : LocationModel?
    
    private var object : MainMenuModel
    private var page = 1
    
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

    private func convertObjectToModel(data : Data) -> Void {
        if let titleObject = self.object.title {
            switch titleObject {
                case "characters":
                    convertCharacter(data: data)
                case "locations":
                    convertLocations(data: data)
                case "episodes":
                        return
                default:
                    return
            }
        }
    }

    
    // MARK: - Character
    private var preLastCharacterId : Int {
        let prelast = self.character?.results[(self.character?.results.count)! - 1]
        return prelast?.id ??  0
    }
    
    public func checkCharacterId(resultId: Int ) -> Void {
        if(preLastCharacterId == resultId ) {
            self.page += 1
            fetchData(page: page)
        }
    }
    
    private func convertCharacter(data : Data) -> Void {
        DispatchQueue.main.async(qos : .background){
            let decoder = JSONDecoder()
            if let json = try? decoder.decode(CharaterModel.self, from: data){
                if self.character == nil  {
                    self.character = json
                } else {
                    self.addCharacters(json)
                    }
            }
            else  {
                print("error json")
            }
        }
    }
    
    private func addCharacters(_  newModel  :  CharaterModel) -> Void  {
        self.character?.info = newModel.info
        for newCharacter  in newModel.results  {
            self.character?.results.append(newCharacter)
        }
    }
    
    //MARK: - location
    private var preLastLocationId : Int {
        let prelast = self.location?.results[(self.location?.results.count)! - 1]
        return prelast?.id ??  0
    }
    
    public func checkLocationId(resultId: Int ) -> Void {
        if(preLastLocationId == resultId ) {
            self.page += 1
            fetchData(page: page)
        }
    }
    
    private func convertLocations(data : Data) -> Void {
        DispatchQueue.main.async(qos : .background){
            let decoder = JSONDecoder()
            if let json = try? decoder.decode(LocationModel.self, from: data){
                if self.location == nil  {
                    self.location = json
                } else {
                    self.addLocations(json)
                    }
            }
            else  {
                print("error json")
            }
        }
    }
    
    private func addLocations(_  newModel  :  LocationModel) -> Void  {
        self.location?.info = newModel.info
        for newCharacter  in newModel.results  {
            self.location?.results.append(newCharacter)
        }
    }
    
}
