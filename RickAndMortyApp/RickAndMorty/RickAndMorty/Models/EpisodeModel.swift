//
//  EpisodeModel.swift
//  RickAndMorty
//
//  Created by Никита Попов on 24.01.2021.
//

import Foundation

struct EpisodeModel: Codable {
    var info: InfoEpisodeModel
    var results: [ResultEpisodeModel]
}

// MARK: - Info
struct InfoEpisodeModel: Codable {
    var count : Int?
    var pages  : Int?
    var next : String?
    var prev  : String?
}

// MARK: - Result
struct ResultEpisodeModel: Codable, Identifiable {
    var id: Int
    var name : String?
    var airDate : String?
    var episode: String?
    var characters: [String?]
    var url: String?
    var created: String?
}

