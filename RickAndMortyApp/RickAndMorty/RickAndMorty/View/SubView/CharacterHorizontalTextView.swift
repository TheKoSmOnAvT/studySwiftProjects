//
//  CharacterHorizontalTextView.swift
//  RickAndMorty
//
//  Created by Никита Попов on 17.01.2021.
//

import SwiftUI

struct CharacterHorizontalTextView: View {
    var title : String
    var data : String
    var grayBackground : Bool = false
    var body: some View {
        HStack {
            Text(title)
                .font(.system(.title2))
                .bold()
                .padding()
            Spacer()
            Text(data).font(.system(.title2))
                .padding()
           
        }.background((grayBackground ? Color.init( red: grayColore, green: grayColore, blue: grayColore, opacity: 1) : Color.white))
    }
    
   @State private var grayColore : Double = 230/255
}

struct CharacterHorizontalTextView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterHorizontalTextView(title: "Name",data : "Rick")
    }
}
