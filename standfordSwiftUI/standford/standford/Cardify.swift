//
//  Cardify.swift
//  standford
//
//  Created by Никита Попов on 18.12.2020.
//  Copyright © 2020 Никита Попов. All rights reserved.
//

import SwiftUI


struct Cardify : ViewModifier, Animatable { //AnimatableModifier
    
    init(isFaceUp : Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    var isFaceUp : Bool {
        rotation < 90
    }
    var rotation : Double
    
    var animatableData: Double {
        get {return rotation}
        set {rotation = newValue}
    }
    
    func body(content: Content) -> some View {
        ZStack {
            Group{
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: lineWidth)
                content
            }.opacity(  isFaceUp ? 1 : 0)
              RoundedRectangle(cornerRadius: cornerRadius).fill()
                .opacity(isFaceUp ? 0 : 1)
            
        }
        .rotation3DEffect(
            Angle.degrees(rotation),
            axis: (0, 1,0)
        )
    }
    private let cornerRadius : CGFloat = 10
    private let lineWidth : CGFloat = 3
}

extension View {
    func cardify(isFaceUp : Bool) -> some View {
        return modifier(Cardify(isFaceUp: isFaceUp))
    }
}
