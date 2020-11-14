//
//  MemoryGame.swift
//  standford
//
//  Created by Никита Попов on 10.11.2020.
//  Copyright © 2020 Никита Попов. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> { //this is like List<t>  but struct
    
    init(numberOfPairsCards: Int,  cardContentFactory :  (Int) -> CardContent){
        cards = Array<Card>()
        for index in 0..<numberOfPairsCards{
            let content =  cardContentFactory(index)
            cards.append(Card(id: index*2,  content: content))
            cards.append(Card(id: index*2+1, content: content))
        }
    }
    
    
    var cards : Array<Card>
    
    func shoose(card: Card)  {
        print("Choose  card: \(card)")
    }
    
    struct Card : Identifiable {
        var id : Int
        var isFaceUp :  Bool = false
        var isMatched :  Bool = false
        var content : CardContent
    }
}
