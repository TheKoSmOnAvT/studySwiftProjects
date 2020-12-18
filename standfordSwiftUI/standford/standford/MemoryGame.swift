//
//  MemoryGame.swift
//  standford
//
//  Created by Никита Попов on 10.11.2020.
//  Copyright © 2020 Никита Попов. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> where CardContent : Equatable { //this is like List<t>  but struct
    
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
    private(set) var cards : Array<Card>
    private var indexOfOneCardWithFaceUp : Int? {
        get {
            return cards.indices.filter {  (index) -> Bool in return cards[index].isFaceUp }.only
        }
        set {
            for indexCard in cards.indices {
                cards[indexCard].isFaceUp = indexCard == newValue
            }
        }
    }
    
    mutating func shoose(card: Card)  {
        if let index = cards.firstIndex(of: card), !cards[index].isFaceUp, !cards[index].isMatched {
            if let potentionalCardMatchIndex = indexOfOneCardWithFaceUp {
                if cards[index].content == cards[potentionalCardMatchIndex].content{
                    cards[index].isMatched = true
                    cards[potentionalCardMatchIndex].isMatched = true
                }
                self.cards[index].isFaceUp = true
            } else {
                indexOfOneCardWithFaceUp = index
            }
            
            
           
        }
    }
    
    struct Card : Identifiable {
        var id : Int
        var isFaceUp :  Bool = false
        var isMatched :  Bool = false
        var content : CardContent
    }
}
