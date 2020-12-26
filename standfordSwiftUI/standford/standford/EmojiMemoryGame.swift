//
//  EmojiMemoryGame.swift
//  standford
//
//  Created by Никита Попов on 10.11.2020.
//  Copyright © 2020 Никита Попов. All rights reserved.
//

import Foundation
import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var  model:  MemoryGame<String> = createMemoryGame()
    
    private static func createMemoryGame() ->  MemoryGame<String> {
        let emoji: Array<String> = ["🎃","☠️","👽","🥶", "X"]
        let randomNumberOfPairs = Int.random(in:2...5)
        return  MemoryGame<String>(numberOfPairsCards: randomNumberOfPairs) { index in
            emoji[index]
        }
    }
    //  MARK:  -  get
    var cards: Array<MemoryGame<String>.Card>{
         model.cards
    }
    
    var numberOfPairs : Int {
        model.numberOfPairs
    }
    //  MARK:  -  set
    
    func shoose(card: MemoryGame<String>.Card)  {
        model.shoose(card: card)
    }
    
    func resetGame(){
        model = EmojiMemoryGame.createMemoryGame()
    }
}
