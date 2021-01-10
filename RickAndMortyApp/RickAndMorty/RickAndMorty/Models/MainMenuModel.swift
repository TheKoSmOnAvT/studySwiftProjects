//
//  MainMenuModel.swift
//  RickAndMorty
//
//  Created by Никита Попов on 10.01.2021.
//

import Foundation

public struct MainMenuModel : Codable, Identifiable {
    public var id = UUID()
    public var url : String?
    public var title : String?
    
}
