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
        let game = EmojiMemoryGame()
        game.shoose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game)
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
    
    @ViewBuilder
    func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched{
            ZStack {
            Pie(startAngle: Angle.degrees(-90), endAngle: Angle.degrees(110-90), clockwise : true).padding(5).opacity(0.4)
            Text(card.content).font(Font.system(size: fontSize(for: size)))
        }.cardify(isFaceUp : card.isFaceUp)
        }
    }
    
    func fontSize(for size : CGSize) ->  CGFloat {
        return min(size.width, size.height) * percentOfGeometry
    }
    
    
    // MARK: - constants
    

    private let percentOfGeometry : CGFloat = 0.7
    
}


