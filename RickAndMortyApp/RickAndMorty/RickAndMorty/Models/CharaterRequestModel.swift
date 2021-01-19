//
//  CharacterModel.swift
//  RickAndMorty
//
//  Created by Никита Попов on 10.01.2021.
//

import Foundation

struct CharaterRequestModel : Codable {
    var info: Info
    var results: [Result]
}

// MARK: - Info
struct Info: Codable {
    var count, pages: Int
    var next: String?
    var prev: String?
}

// MARK: - Result
struct Result: Codable, Identifiable {
    var id: Int
    var name: String
    var status: String
    var species: String
    var type: String
    var gender: String
    var origin, location: Location
    var image: String
    var episode: [String]
    var url: String
    var created: String
}

// MARK: - Location
struct Location: Codable {
    var name: String
    var url: String
}

extension Result {
    var episodesURLToInt : [Int] {
        [1,2,3]
    }
    var createdString: String {
        let formatter = DateFormatter()
        let created: Date? = formatter.date(from: self.created)
        formatter.dateFormat = "dd-MMM-yyyy"
        return "formatter.string(from: created )"
    }
}
