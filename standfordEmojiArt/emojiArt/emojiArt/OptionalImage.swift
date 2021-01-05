//
//  OptionalImage.swift
//  emojiArt
//
//  Created by Никита Попов on 05.01.2021.
//

import Foundation
import SwiftUI

struct OptionalImage : View {
    var image : UIImage?
    
    var body : some View {
        Group {
            if image  != nil {
                Image(uiImage : image!)
            }
        }
    }
}
