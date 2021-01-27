//
//  LoaderView.swift
//  RickAndMorty
//
//  Created by Никита Попов on 27.01.2021.
//

import SwiftUI

struct LoaderView: View {
    var body: some View {
        // TO DO: custom animated logo loading
        Text("Loading...")
        ProgressView()
    }
}

struct LoaderView_Previews: PreviewProvider {
    static var previews: some View {
        LoaderView()
    }
}
