//
//  CharacterModel.swift
//  RickAndMorty
//
//  Created by Никита Попов on 10.01.2021.
//

import Foundation

public struct CharaterRequestModel : Codable , Identifiable{
    public var id = UUID()
    public var info  : Info?
    //public var result : [Character]?
}

public struct Character : Codable {
    var id : Int
    var name : String
    var status : String
    var species : String
    var type : String
    var gender : String
    var origin : Origin?
    var location : Location?
    var image : String
    var episode : [String]
    var url : String
    var created : String
}
public struct Origin : Codable {
    var name : String
    var url : String
}
public struct Location : Codable{
    var name : String
    var url : String
}
public struct Info : Codable {
    var count : Int
    var pages : Int
    var next : String
    var prev : String
}
