//
//  emojiArtApp.swift
//  emojiArt
//
//  Created by Никита Попов on 28.12.2020.
//

import SwiftUI

@main
struct emojiArtApp: App {
    @State var store = EmojiArtDocumentStore()
    init(){

    }
    var body: some Scene {
        WindowGroup {
            EmojiArtDocumentChooser().environmentObject(store)
        }
    }
}
