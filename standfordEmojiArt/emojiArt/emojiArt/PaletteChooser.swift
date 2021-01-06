//
//  PaletteChooser.swift
//  emojiArt
//
//  Created by Никита Попов on 06.01.2021.
//

import SwiftUI

struct PaletteChooser: View {
    @Binding var chosenPalette : String 
    @ObservedObject var document : EmojiArtDocument
    
    var body: some View {
        HStack{
            Stepper(
                onIncrement: {
                    self.chosenPalette =  self.document.palette(after: self.chosenPalette)
                },
                onDecrement: {
                    self.chosenPalette = self.document.palette(before: self.chosenPalette)
                },
                label: {
                    EmptyView()
                })
            Text(self.document.paletteNames[self.chosenPalette] ??  "")
        }
        .fixedSize(horizontal: true, vertical: false)
    }
}

struct PaletteChooser_Previews: PreviewProvider {
    static var previews: some View {
        PaletteChooser(chosenPalette: Binding.constant("1235"), document: EmojiArtDocument())
    }
}
