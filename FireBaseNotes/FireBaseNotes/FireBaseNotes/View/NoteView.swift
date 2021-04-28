//
//  NoteView.swift
//  FireBaseNotes
//
//  Created by Никита Попов on 25.04.2021.
//

import SwiftUI

struct NoteView: View {
    var cd : CoreData
    var note : NoteModel
    var body: some View {
        VStack {
            Text(note.title ?? "")
            Text(note.text ?? "")
        }.onDisappear {
            print("!!")
        }
    }
}

//struct NoteView_Previews: PreviewProvider {
//    static var previews: some View {
//        NoteView()
//    }
//}
