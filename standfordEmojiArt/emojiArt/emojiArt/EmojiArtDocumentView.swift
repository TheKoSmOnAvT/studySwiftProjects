//
//  EmojiArtDocumentView.swift
//  emojiArt
//
//  Created by Никита Попов on 28.12.2020.
//

import SwiftUI

struct EmojiArtDocumentView: View {
    @ObservedObject var document : EmojiArtDocument
    var body: some View {
        VStack {
            ScrollView(.horizontal)  {
                HStack {
                    ForEach(EmojiArtDocument.palette.map{String($0)}, id : \.self)  { emoji in
                        Text(emoji)
                            .font(Font.system(size: self.defaultEmojiSize))
                    }
                }
            }
            .padding(.horizontal)
            Rectangle().foregroundColor(Color.blue)
                .edgesIgnoringSafeArea([.horizontal, .bottom])
        }
    }
    
    private let defaultEmojiSize : CGFloat  = 30
}


//struct ContentView_PreEmojiArtDocumentViewiewProvEmojiArtDocumentView  static var previews: some View {
//        ContentView()
//    }
//}
