//
//  Location.swift
//  RickAndMorty
//
//  Created by Никита Попов on 24.01.2021.
//

import Foundation



struct LocationModel: Codable {
    var info: InfoLocationModel?
    var results: [ResultLocationModel]
}

// MARK: - Info
struct InfoLocationModel: Codable {
    var count, pages: Int
    var next: String?
    var prev: String?
}

// MARK: - Result
struct ResultLocationModel: Codable, Identifiable {
    var id: Int
    var name, type, dimension: String
    var residents: [String]
    var url: String?
    var created: String?
}

