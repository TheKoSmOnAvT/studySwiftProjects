//
//  CharacterModel.swift
//  RickAndMorty
//
//  Created by Никита Попов on 10.01.2021.
//

import Foundation

struct CharaterRequestModel : Codable {
    let info: Info
    let results: [Result]
}

// MARK: - Info
struct Info: Codable {
    let count, pages: Int
    let next: String?
    let prev: String?
}

// MARK: - Result
struct Result: Codable, Identifiable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin, location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

// MARK: - Location
struct Location: Codable {
    let name: String
    let url: String
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
