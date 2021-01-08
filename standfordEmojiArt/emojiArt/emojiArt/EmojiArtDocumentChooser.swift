//
//  EmojiArtDocumentChooser.swift
//  emojiArt
//
//  Created by Никита Попов on 07.01.2021.
//

import SwiftUI

struct EmojiArtDocumentChooser: View {
    @EnvironmentObject var store : EmojiArtDocumentStore
    @State private var editMode : EditMode = .inactive
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.documents) { document in
                    NavigationLink(destination: EmojiArtDocumentView(document: document)
                                    .navigationTitle(self.store.name(for: document))) {
                        EditableText(self.store.name(for: document), isEditing: self.editMode.isEditing) { name in
                            self.store.setName(name, for: document)
                        }
                    }
                }
                .onDelete { indexSet in
                    indexSet.map {self.store.documents[$0]}.forEach { document in
                        self.store.removeDocument(document)
                    }
                }
            }
            .navigationTitle(self.store.name)
            .navigationBarItems(
                leading: Button(action: {
                    self.store.addDocument()
                },
                label: {
                    Image(systemName: "plus").imageScale(.large)
                
                }),
                    trailing: EditButton()
            )
            .environment(\.editMode, $editMode)
        }
    }
}

struct EmojiArtDocumentChooser_Previews: PreviewProvider {
    static var previews: some View {
        EmojiArtDocumentChooser()
    }
}
