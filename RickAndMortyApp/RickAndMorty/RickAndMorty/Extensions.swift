//
//  extensions.swift
//  RickAndMorty
//
//  Created by Никита Попов on 07.02.2021.
//

import Foundation


extension  String {
    var formatDate: String {
        let str = self.components(separatedBy: "T")
        return str[0]
    }
}
