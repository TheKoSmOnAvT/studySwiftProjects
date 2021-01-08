//
//  EmojiArtDocumentView.swift
//  emojiArt
//
//  Created by Никита Попов on 28.12.2020.
//

import SwiftUI

struct EmojiArtDocumentView: View {
    @ObservedObject var document : EmojiArtDocument
    @State private var chosenPalette : String
    init(document : EmojiArtDocument){
        self.document = document
        _chosenPalette = State(wrappedValue: document.defaultPalette)
    }
    var body: some View {
        VStack {
            HStack{
                PaletteChooser(chosenPalette  : $chosenPalette, document  : document)
                ScrollView(.horizontal)  {
                    HStack {
                        ForEach(chosenPalette.map{String($0)}, id : \.self)  { emoji in
                            Text(emoji)
                                .font(Font.system(size: self.defaultEmojiSize))
                                .onDrag{ return NSItemProvider(object : emoji as NSString) }
                        }
                    }
                }
                .onAppear{
                    self.chosenPalette = self.document.defaultPalette
                }
            }
            GeometryReader {  geometry  in
                ZStack {
                    Rectangle().foregroundColor(Color.blue).overlay(
                            OptionalImage(image: self.document.backgroundImgage)
                                .scaleEffect(self.zoomScale)
                                .offset(self.panOffSet)
                    )
                    .gesture(self.doubleTapZoom(in: geometry.size))
                    if self.isLoading {
                        Image(systemName: "hourglass").imageScale(.large).spinning()
                        } else {
                            ForEach(self.document.emojis) { emoji in
                                Text(emoji.text)
                                    .font(animatableWithSize: emoji.fontSize * self.zoomScale)
                                    .position(self.position(for: emoji, in: geometry.size))
                        }
                    }
                }
                .clipped()
                .gesture(self.panGesture())
                .gesture(self.zoomGesture())
                .edgesIgnoringSafeArea([.horizontal, .bottom])
                .onReceive(self.document.$backgroundImgage){ image in
                    self.zoomToFit(image, in: geometry.size)
                }
                .onDrop(of: ["public.image", "public.text"], isTargeted: nil) { provaders, location  in
                    var location = geometry.convert(location,  from: .global)
                    location  =  CGPoint(x: location.x  - geometry.size.width/2, y: location.y - geometry.size.height/2)
                    location = CGPoint(x: location.x - self.panOffSet.width, y: location.y - self.panOffSet.height)
                    location  =  CGPoint(x: location.x / self.zoomScale, y: location.y / self.zoomScale)
                    return self.drop(provaders: provaders, at : location)
                }
                .navigationBarItems(trailing: Button(action: {
                    if let url = UIPasteboard.general.url , url != self.document.backgroundURl   {
                        self.confirmBackgroundPaste = true
                    } else {
                        self.explainBackgroundPaste = true
                    }
                }, label: {
                    Image(systemName: "doc.on.clipboard").imageScale(.large)
                        .alert(isPresented: self.$explainBackgroundPaste, content: {
                            return Alert(
                                title: Text("Paste background"),
                                message: Text("Copy the URL of an image to the clip board touch this button to make it the background of you document"),
                                dismissButton: .default(Text("OK")))
                        })
                }))
            }
            .zIndex(-1)
        }
        .alert(isPresented: self.$confirmBackgroundPaste) {
             Alert (
                title: Text("Paste background"),
                message: Text("Replace your background \(UIPasteboard.general.url?.absoluteString ?? "none")"),
                primaryButton:  .default(Text("OK")) {
                    self.document.backgroundURl = UIPasteboard.general.url
                },
                secondaryButton: .cancel()
             )
        }
    }
    @State private var explainBackgroundPaste = false
    @State private var confirmBackgroundPaste = false
    
    
    var isLoading :  Bool {
        document.backgroundURl != nil && document.backgroundImgage == nil
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
        if let image = image, image.size.width > 0, image.size.height > 0, size.height > 0, size.width > 0 {
            let hZoom = size.width / image.size.width
            let vZoom = size.height / image.size.height
            document.steadyStatePanOffSet = .zero
            document.steadyStateZoomScale = min(hZoom,vZoom)
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
            self.document.backgroundURl =  url
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
                document.steadyStateZoomScale *= finalGestureScale
        }
    }

    @GestureState private var gesturePanOffSet : CGSize = .zero
    
    private var panOffSet : CGSize {
        (document.steadyStatePanOffSet + gesturePanOffSet ) * zoomScale
    }

    private func panGesture() -> some Gesture {
        DragGesture()
            .updating($gesturePanOffSet) { latestDragGestuerValue, gesturePanOffSet, trasaction in
                gesturePanOffSet = latestDragGestuerValue.translation / self.zoomScale
            }
            .onEnded { finalDragGestuerValue in
                document.steadyStatePanOffSet = document.steadyStatePanOffSet + (finalDragGestuerValue.translation / self.zoomScale)
                
            }
    }
    
    
    private let defaultEmojiSize : CGFloat  = 30

    @GestureState private var gestureZoomScale : CGFloat = 1.0
    
    private var zoomScale : CGFloat {
        document.steadyStateZoomScale * gestureZoomScale
    }
    
}


//struct ContentView_PreEmojiArtDocumentViewiewProvEmojiArtDocumentView  static var previews: some View {
//        ContentView()
//    }
//}


