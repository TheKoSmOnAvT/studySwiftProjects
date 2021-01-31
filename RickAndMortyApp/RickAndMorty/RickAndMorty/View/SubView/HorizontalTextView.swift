//
//  CharacterHorizontalTextView.swift
//  RickAndMorty
//
//  Created by Никита Попов on 17.01.2021.
//

import SwiftUI

struct HorizontalTextView: View {
    var title : String
    var data : String
    var grayBackground : Bool = false
    var body: some View {
        if(grayBackground) {
            HStack {
                Text(title)
                    .font(.system(.title2))
                    .bold()
                    .padding()
                Spacer()
                Text(data)
                    .font(.system(.title2))
                    .padding()
            }
        } else {
            HStack {
                Text(title)
                    .foregroundColor(Color.black)
                    .font(.system(.title2))
                    .bold()
                    .padding()
                Spacer()
                Text(data)
                    .foregroundColor(Color.black)
                    .font(.system(.title2))
                    .padding()
               
            }.background(Color.init( red: grayColore, green: grayColore, blue: grayColore, opacity: 1))
        }
    }
    
   @State private var grayColore : Double = 230/255
}

struct CharacterHorizontalTextView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalTextView(title: "Name",data : "Rick",  grayBackground: true)
    }
}
