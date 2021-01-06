//
//  EmojuArtDocument.swift
//  emojiArt
//
//  Created by Никита Попов on 28.12.2020.
//

import SwiftUI
import Combine

class EmojiArtDocument  : ObservableObject {
    static let palette : String = "👨‍🚀🚀👩‍💻🧛‍♂️👽🤖🏀🥎🏉🚑"

    @Published private var emojiArt : EmojiArt
    
    @Published private(set) var backgroundImgage :  UIImage?
    var emojis  : [EmojiArt.Emoji] { emojiArt.emojis}
    
    private static let unitled = "EmojiArt.Untitled"
    private var autosaveCabcellable  : AnyCancellable?
    
    var backgroundURl :  URL? {
        set {
            emojiArt.backgroundURL =  newValue?.imageURL
            fetchBackgroundImageData()
        }
        get {
            emojiArt.backgroundURL
        }
    }
    
    
    init(){
        emojiArt = EmojiArt(json: UserDefaults.standard.data(forKey: EmojiArtDocument.unitled)) ?? EmojiArt()
        autosaveCabcellable =  $emojiArt.sink { emojiArt in
            print("json \(emojiArt.json?.utf8  ?? "nil" )")
            UserDefaults.standard.set(emojiArt.json ,forKey: EmojiArtDocument.unitled)
        }
        fetchBackgroundImageData()
    }
    
    //MARK: - Intents(s)
    func addEmoji(_ emoji : String, at location : CGPoint, size :CGFloat) {
        emojiArt.addEmoji(text: emoji, x: Int(location.x), y: Int(location.y), size: Int(size))
    }
    
    func moveEmoji(_ emoji  : EmojiArt.Emoji, by offset : CGSize) {
        if let index = emojiArt.emojis.firstIndex(matching  : emoji)  {
            emojiArt.emojis[index].x += Int(offset.width)
            emojiArt.emojis[index].y += Int(offset.height)
        }
    }
    
    func scaleEmoji(_ emoji : EmojiArt.Emoji, by scale : CGFloat){
        if let index = emojiArt.emojis.firstIndex(matching  : emoji)  {
            emojiArt.emojis[index].size  =  Int((CGFloat(emojiArt.emojis[index].size)*scale.rounded(.toNearestOrEven)))
        }
    }
    
    func setBackGroundURL(_ url : URL?){
        emojiArt.backgroundURL = url?.imageURL
        fetchBackgroundImageData()
    }
    private var fetchImageCancellaable : AnyCancellable?
    
    private func fetchBackgroundImageData() {
        backgroundImgage = nil
        if let url = self.emojiArt.backgroundURL {
            fetchImageCancellaable?.cancel()
            fetchImageCancellaable = URLSession.shared.dataTaskPublisher(for: url)
                .map{data, urlResponse in  UIImage(data: data)  }
                .receive(on: DispatchQueue.main)
                .replaceError(with: nil)
                .assign(to: \.backgroundImgage, on: self)
                
        }
    }
}
extension EmojiArt.Emoji  {
    var fontSize  : CGFloat  {CGFloat(self.size)}
    var location :  CGPoint {CGPoint(x:  CGFloat(x), y : CGFloat(y) ) }
}
