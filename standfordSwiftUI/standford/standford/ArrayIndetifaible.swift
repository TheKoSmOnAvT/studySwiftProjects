//
//  ArrayIndetifaible.swift
//  standford
//
//  Created by Никита Попов on 17.12.2020.
//  Copyright © 2020 Никита Попов. All rights reserved.
//

import Foundation

extension Array where  Element: Identifiable {
    func firstIndex(of item: Element) -> Int? {
        for index in 0..<self.count{
            if(self[index].id == item.id){
                return index
            }
        }
        return nil
    }
}


extension Array {
    var only: Element? {
        return count ==  1 ? first :  nil
    }
}
