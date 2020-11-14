//
//  RGB.swift
//  Calculator
//
//  Created by Никита Попов on 25.06.2020.
//  Copyright © 2020 Никита Попов. All rights reserved.
//

import Foundation
import UIKit

public class RGB {
    var red : CGFloat? = nil
    var blue : CGFloat?  = nil
    var green : CGFloat?  = nil
    var numColor : Int? = nil
    init(_ rd: CGFloat , _ gr: CGFloat  , _ bl: CGFloat  ){
        red = rd
        green = gr
        blue = bl
    }
    init(_ rd: CGFloat , _ gr: CGFloat  , _ bl: CGFloat, _ num : Int  ){
        red = rd
        green = gr
        blue = bl
        numColor = num
    }
}
