//
//  EmojiArt.swift
//  emojiArt
//
//  Created by Никита Попов on 28.12.2020.
//

import Foundation

struct EmojiArt {
    var backgroundURL : URL?
    var emojis = [Emoji]()
    
    struct Emoji : Identifiable {
        let id : Int
        let text : String
        var x : Int
        var y : Int
        var size : Int
        
        init(id: Int, text: String, x: Int, y: Int, size: Int) {
            self.id = id
            self.text = text
            self.x = x
            self.y = y
            self.size = size
        }
    }
    
    private var uniqueEmojiId = 0
    mutating func addEmoji(text : String, x : Int, y : Int, size : Int){
        self.emojis.append(Emoji(id: uniqueEmojiId, text: text, x: x, y: y, size: size ))
        self.uniqueEmojiId = uniqueEmojiId + 1
    }
}
