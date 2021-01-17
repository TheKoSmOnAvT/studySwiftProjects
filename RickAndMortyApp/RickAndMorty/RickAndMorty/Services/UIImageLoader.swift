//
//  UIImageLoader.swift
//  RickAndMorty
//
//  Created by Никита Попов on 14.01.2021.
//

import SwiftUI
import Combine
import Foundation

public class UIImageLoader : ObservableObject {
    @Published var image : UIImage? = UIImage(systemName: "person.fill.questionmark" )
    
    private var fetchImageCancellaable : AnyCancellable?

    public func fetchImage(url : String) -> Void {
        image = UIImage(systemName: "person.fill.questionmark" )
        if let url = URL(string: url) {
            fetchImageCancellaable = URLSession.shared.dataTaskPublisher(for: url)
                .map{data, urlResponse in  UIImage(data: data)  }
                .receive(on: DispatchQueue.main)
                .replaceError(with: nil)
                .assign(to: \.image, on: self)
                
        }
    }
}
