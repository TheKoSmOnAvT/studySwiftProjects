//
//  ContentView.swift
//  standford
//
//  Created by Никита Попов on 05.11.2020.
//  Copyright © 2020 Никита Попов. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var viewModel : EmojiMemoryGame
    var body: some View {
        HStack  {
            ForEach(viewModel.cards) { card in
                CardView(card: card, numberOfPairs: viewModel.numberOfPairs).onTapGesture {
                    viewModel.shoose(card: card)
                }.aspectRatio(0.66, contentMode: .fit)
            }
        }
        .padding()
        .foregroundColor(Color.orange)
        .font(Font.largeTitle)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: EmojiMemoryGame())
    }
}


struct CardView : View {
    var card : MemoryGame<String>.Card
    var numberOfPairs : Int
    var body: some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 10).fill(Color.white)
                RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 3)
                Text(card.content).font(numberOfPairs >= 4 ? Font.title : Font.largeTitle)
            } else {
                      RoundedRectangle(cornerRadius: 10).fill()
            }
        }
    }
}
