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
    @State private var showPaletteEditor = false
    
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
            Image(systemName: "keyboard").imageScale(.large)
                .onTapGesture {
                    self.showPaletteEditor = true
                }
                .popover(isPresented: $showPaletteEditor, content: {
                    PaletteEdition(choosenPalette: self.$chosenPalette)
                        .environmentObject(document)
                        .frame(minWidth: 300, minHeight: 500 )
                })
        }
        .fixedSize(horizontal: true, vertical: false)
    }
}



struct PaletteEdition : View {
    @EnvironmentObject var document : EmojiArtDocument
    @Binding var choosenPalette : String
    @State private var paletteName : String = ""
    @State private var emojisToAdd : String = ""
    
    
    var body : some View {
        VStack( spacing: 0) {
            Text("Editor").font(.headline).padding()
            Divider()
            Form {
                Section {
                    TextField("Palette Text", text: $paletteName, onEditingChanged : { began in
                        if  !began {
                            self.document.renamePalette(self.choosenPalette, to: self.paletteName)
                        }
                    })
                    TextField("Add emoji", text: $emojisToAdd, onEditingChanged : { began in
                        if  !began {
                            self.choosenPalette = self.document.addEmoji(self.emojisToAdd, toPalette: self.choosenPalette)
                            self.emojisToAdd = ""
                        }
                    })
                }
                Section(header: Text("Remove Emoji")) {
                        Grid( choosenPalette.map{String($0)}, id : \.self ){ emoji in
                            Text(emoji)
                                .font(Font.system(size: fontSize))
                                .onTapGesture {
                                    self.choosenPalette = self.document.removeEmoji(emoji, fromPalette: self.choosenPalette)
                                }
                        }
                        .frame(height: self.height)
                }
            }
        }.onAppear {
            self.paletteName = self.document.paletteNames[self.choosenPalette] ??  ""
        }
    }
    private var  height : CGFloat{
        CGFloat((choosenPalette.count - 1) / 6)  * 70 + 70
    }
    
    private let fontSize : CGFloat = 40
}


struct PaletteChooser_Previews: PreviewProvider {
    static var previews: some View {
        PaletteChooser(chosenPalette: Binding.constant("1235"), document: EmojiArtDocument())
    }
}
