//
//  ObjectViewModel.swift
//  RickAndMorty
//
//  Created by Никита Попов on 10.01.2021.
//

import Foundation

public class ObjectViewModel : ObservableObject {
    @Published var character : CharaterRequestModel?
    
    var lastIndex : Int {
        self.character?.results.count  ??  0
    }
    
    private var page = 1
    
    public func checkIndexCharacter(resultId: Int ) -> Bool {
        let index = getIndexCharacter(resultId)
        if(lastIndex - 4 < index ) {
            print("UPDATE")
            self.page += 1
            fetchData(page: page)
            return true
        } else {
            return false
        }
    }
    
    private func getIndexCharacter(_ resultId: Int) -> Int {
        for i in 0...(self.character?.results.count ?? 0) {
            if(self.character?.results[i].id == resultId) {
                return i
            }
        }
        return 0
    }
    
    
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
            if let json = try? decoder.decode(CharaterRequestModel.self, from: data){
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
    private func addCharacters(_  newModel  :  CharaterRequestModel) -> Void  {
        self.character?.info = newModel.info
        for newCharacter  in newModel.results  {
            self.character?.results.append(newCharacter)
        }
    }
    
    
    
}
