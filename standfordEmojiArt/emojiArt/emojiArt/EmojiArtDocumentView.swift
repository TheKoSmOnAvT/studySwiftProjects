//
//  EmojiArtDocumentView.swift
//  emojiArt
//
//  Created by Никита Попов on 28.12.2020.
//

import SwiftUI

struct EmojiArtDocumentView: View {
    @ObservedObject var document : EmojiArtDocument
    var body: some View {
        VStack {
            ScrollView(.horizontal)  {
                HStack {
                    ForEach(EmojiArtDocument.palette.map{String($0)}, id : \.self)  { emoji in
                        Text(emoji)
                            .font(Font.system(size: self.defaultEmojiSize))
                            .onDrag{ return NSItemProvider(object : emoji as NSString) }
                    }
                }
            }
            .padding(.horizontal)
            GeometryReader {  geometry  in
                ZStack {
                    Rectangle().foregroundColor(Color.blue).overlay(
                            OptionalImage(image: self.document.backgroundImgage)
                                .scaleEffect(self.zoomScale)
                                .offset(self.panOffSet)
                    )
                    .gesture(self.doubleTapZoom(in: geometry.size))
                    
                    ForEach(self.document.emojis) { emoji in
                        Text(emoji.text)
                            .font(animatableWithSize: emoji.fontSize * self.zoomScale)
                            .position(self.position(for: emoji, in: geometry.size))
                    }
                }
                .clipped()
                .gesture(self.panGesture())
                .gesture(self.zoomGesture())
                .edgesIgnoringSafeArea([.horizontal, .bottom])
                .onDrop(of: ["public.image", "public.text"], isTargeted: nil) { provaders, location  in
                    var location = geometry.convert(location,  from: .global)
                    location  =  CGPoint(x: location.x  - geometry.size.width/2, y: location.y - geometry.size.height/2)
                    location = CGPoint(x: location.x - self.panOffSet.width, y: location.y - self.panOffSet.height)
                    location  =  CGPoint(x: location.x / self.zoomScale, y: location.y / self.zoomScale)
                    return self.drop(provaders: provaders, at : location)
                }
            }
        }
    }
    private func doubleTapZoom(in size : CGSize) -> some Gesture {
        TapGesture(count: 2)
            .onEnded {
                withAnimation {
                    self.zoomToFit(self.document.backgroundImgage, in: size)
                }
            }
    }
    
    private func zoomToFit(_ image: UIImage?, in size : CGSize){
        if let image = image, image.size.width > 0, image.size.height > 0 {
            let hZoom = size.width / image.size.width
            let vZoom = size.height / image.size.height
            self.steadyStatePanOffSet = .zero
            self.steadyStateZoomScale = min(hZoom,vZoom)
        }
         
    }
    
    private func font(for emoji  : EmojiArt.Emoji)  ->  Font{
        Font.system(size: emoji.fontSize * self.zoomScale)
    }
    
    private func position(for emoji  : EmojiArt.Emoji, in size  :  CGSize )  -> CGPoint {
        var location = emoji.location
        location = CGPoint(x: location.x * self.zoomScale, y: location.y * self.zoomScale )
        location = CGPoint(x: location.x + size.width/2, y: location.y + size.height/2)
        location = CGPoint(x: location.x + panOffSet.width, y: location.y + panOffSet.height)
        return location
    }
    
    private func drop(provaders: [NSItemProvider], at location : CGPoint) -> Bool {
        var found = provaders.loadFirstObject(ofType: URL.self) { url in
            self.document.setBackGroundURL(url)
        }
        if !found {
            found = provaders.loadObjects(ofType: String.self) {  string in
                self.document.addEmoji(string, at: location, size: defaultEmojiSize)
            }
        }
        return found
    }
    private func zoomGesture () -> some Gesture {
        MagnificationGesture()
            .updating($gestureZoomScale) { latestGestureScale, gestureZoomScale, transaction in
                gestureZoomScale = latestGestureScale
            }
            .onEnded { finalGestureScale in
                self.steadyStateZoomScale *= finalGestureScale
        }
    }
    @State private var steadyStatePanOffSet : CGSize = .zero
    @GestureState private var gesturePanOffSet : CGSize = .zero
    
    private var panOffSet : CGSize {
        (steadyStatePanOffSet + gesturePanOffSet ) * zoomScale
    }

    private func panGesture() -> some Gesture {
        DragGesture()
            .updating($gesturePanOffSet) { latestDragGestuerValue, gesturePanOffSet, trasaction in
                gesturePanOffSet = latestDragGestuerValue.translation / self.zoomScale
            }
            .onEnded { finalDragGestuerValue in
                self.steadyStatePanOffSet = self.steadyStatePanOffSet + (finalDragGestuerValue.translation / self.zoomScale)
                
            }
    }
    
    
    private let defaultEmojiSize : CGFloat  = 30
    @State private var steadyStateZoomScale : CGFloat =  1.0
    @GestureState private var gestureZoomScale : CGFloat = 1.0
    
    private var zoomScale : CGFloat {
        steadyStateZoomScale * gestureZoomScale
    }
    
}


//struct ContentView_PreEmojiArtDocumentViewiewProvEmojiArtDocumentView  static var previews: some View {
//        ContentView()
//    }
//}


