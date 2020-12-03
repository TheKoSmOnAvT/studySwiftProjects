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
        cards.shuffle()
        numberOfPairs = numberOfPairsCards
    }

    var numberOfPairs : Int
    var cards : Array<Card>
    
    mutating func shoose(card: Card)  {
       let index = getIndex(card: card)
        self.cards[index].isFaceUp = !self.cards[index].isFaceUp
    }
    
    func getIndex(card: Card) -> Int{
        for i in 0..<cards.count {
            if cards[i].id == card.id {
                return i
            }
        }
        return -1
    }
    
    struct Card : Identifiable {
        var id : Int
        var isFaceUp :  Bool = false
        var isMatched :  Bool = false
        var content : CardContent
    }
}
