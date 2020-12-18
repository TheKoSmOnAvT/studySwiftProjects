//
//  Cardify.swift
//  standford
//
//  Created by Никита Попов on 18.12.2020.
//  Copyright © 2020 Никита Попов. All rights reserved.
//

import SwiftUI


struct Cardify : ViewModifier {
    var isFaceUp : Bool
    
    func body(content: Content) -> some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: lineWidth)
                content
            } else {
                  RoundedRectangle(cornerRadius: cornerRadius).fill()
            }
        }
    }
    private let cornerRadius : CGFloat = 10
    private let lineWidth : CGFloat = 3
}

extension View {
    func cardify(isFaceUp : Bool) -> some View {
        return modifier(Cardify(isFaceUp: isFaceUp))
    }
}
