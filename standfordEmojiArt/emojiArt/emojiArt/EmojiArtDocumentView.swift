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
                            .onDrag{ return NSItemProvider(object : emoji as NSString) }
                    }
                }
            }
            .padding(.horizontal)
            GeometryReader {  geometry  in
                ZStack {
                    Rectangle().foregroundColor(Color.blue).overlay(
                        Group {
                            if self.document.backgroundImgage  != nil {
                                Image(uiImage : self.document.backgroundImgage!)
                            }
                        }
                    )
                        .edgesIgnoringSafeArea([.horizontal, .bottom])
                        .onDrop(of: ["public.image", "public.text"], isTargeted: nil) { provaders, location  in
                            var location = geometry.convert(location,  from: .global)
                            location  =  CGPoint(x: location.x  - geometry.size.width/2, y: location.y - geometry.size.height/2)
                            return self.drop(provaders: provaders, at : location)
                    }
                    ForEach(self.document.emojis) { emoji in
                        Text(emoji.text)
                            .font(self.font(for: emoji))
                            .position(self.position(for: emoji, in: geometry.size))
                            
                    }
                }
            }
        }
    }
    
    private func font(for emoji  : EmojiArt.Emoji)  ->  Font{
        Font.system(size: emoji.fontSize)
    }
    
    private func position(for emoji  : EmojiArt.Emoji, in size  :  CGSize )  -> CGPoint {
        CGPoint(x: emoji.location.x + size.width/2, y: emoji.location.y + size.height/2)
    }
    
    private func drop(provaders: [NSItemProvider], at location : CGPoint) -> Bool {
        var found = provaders.loadFirstObject(ofType: URL.self) { url in
            self.document.setBackGroundURL(url)
        }
        if !found {
            found = provaders.loadObjects(ofType: String.self) {  string in
                self.document.addEmoji(string, at: location, size: defaultEmojiSize)
            }
        }
        return found
    }
    private let defaultEmojiSize : CGFloat  = 30
}


//struct ContentView_PreEmojiArtDocumentViewiewProvEmojiArtDocumentView  static var previews: some View {
//        ContentView()
//    }
//}
