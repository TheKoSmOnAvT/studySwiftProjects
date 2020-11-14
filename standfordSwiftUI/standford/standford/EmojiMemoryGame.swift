//
//  EmojiMemoryGame.swift
//  standford
//
//  Created by Никита Попов on 10.11.2020.
//  Copyright © 2020 Никита Попов. All rights reserved.
//

import Foundation
import SwiftUI

class EmojiMemoryGame  {
    private var  model :  MemoryGame<String> = createMemoryGame()
        
    static func createMemoryGame() ->  MemoryGame<String> {
        let emoji : Array<String> = ["🎃","☠️","👽","🥶"]
        return  MemoryGame<String>(numberOfPairsCards: emoji.count) { index in
            emoji[index]
        }
    }
    //  MARK:  -  get
    var cards: Array<MemoryGame<String>.Card>{
         model.cards
    }
    //  MARK:  -  set
    
    func shoose(card: MemoryGame<String>.Card)  {
        model.shoose(card: card)
    }
}
