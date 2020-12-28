//
//  emojiArtApp.swift
//  emojiArt
//
//  Created by Никита Попов on 28.12.2020.
//

import SwiftUI

@main
struct emojiArtApp: App {
    var body: some Scene {
        WindowGroup {
            EmojiArtDocumentView(document: EmojiArtDocument())
        }
    }
}
