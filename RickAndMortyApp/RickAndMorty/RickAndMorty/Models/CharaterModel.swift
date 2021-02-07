//
//  CharacterModel.swift
//  RickAndMorty
//
//  Created by Никита Попов on 10.01.2021.
//

import Foundation

struct CharaterModel : Codable {
    var info: InfoCharaterModel
    var results: [ResultCharaterModel]
}

// MARK: - Info
struct InfoCharaterModel: Codable {
    var count : Int?
    var pages: Int?
    var next: String?
    var prev: String?
}

// MARK: - Result
struct ResultCharaterModel: Codable, Identifiable {
    var id: Int
    var name: String?
    var status: String?
    var species: String?
    var type: String?
    var gender: String?
    var origin, location: Location?
    var image: String?
    var episode: [String?]
    var url: String?
    var created: String?
}

// MARK: - Location
struct Location: Codable {
    var name: String
    var url: String
}


