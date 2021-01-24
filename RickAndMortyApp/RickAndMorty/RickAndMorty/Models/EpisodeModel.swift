//
//  EpisodeModel.swift
//  RickAndMorty
//
//  Created by Никита Попов on 24.01.2021.
//

import Foundation

struct EpisodeModel: Codable {
    let info: InfoEpisodeModel
    let results: [ResultEpisodeModel]
}

// MARK: - Info
struct InfoEpisodeModel: Codable {
    let count, pages: Int
    let next: String?
    let prev: String?
}

// MARK: - Result
struct ResultEpisodeModel: Codable {
    let id: Int
    let name, airDate, episode: String
    let characters: [String]
    let url: String
    let created: String
}

