//
//  CharcterView.swift
//  RickAndMorty
//
//  Created by Никита Попов on 15.01.2021.
//

import SwiftUI

struct CharcterView: View {
    var character : Result
    
    var body: some View {
        Text(character.name)
    }
}

//struct CharcterView_Previews: PreviewProvider {
//    static var previews: some View {
//        CharcterView()
//    }
//}
