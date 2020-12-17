//
//  ContentView.swift
//  standford
//
//  Created by Никита Попов on 05.11.2020.
//  Copyright © 2020 Никита Попов. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel : EmojiMemoryGame
    var body: some View {
        Grid(viewModel.cards) { card in
            CardView(card: card, numberOfPairs: viewModel.numberOfPairs).onTapGesture {
                viewModel.shoose(card: card)
            }
            .padding(6)
        }
        .padding()
        .foregroundColor(Color.orange)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}


struct CardView : View {
    var card : MemoryGame<String>.Card
    var numberOfPairs : Int
    var body: some View {
        GeometryReader ( content: { geometry in
            body(for: geometry.size)
        })
    }
    
    func body(for size: CGSize) -> some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: lineWidth)
                Text(card.content)
            } else {
                if !card.isMatched {
                      RoundedRectangle(cornerRadius: cornerRadius).fill()
                }
            }
        }
    .font(Font.system(size: fontSize(for: size)))
    }
    
    func fontSize(for size : CGSize) ->  CGFloat {
        return min(size.width, size.height) * percentOfGeometry
    }
    
    
    // MARK: - constants
    
    let cornerRadius : CGFloat = 10
    let lineWidth : CGFloat = 3
    let percentOfGeometry : CGFloat = 0.7
    
}
