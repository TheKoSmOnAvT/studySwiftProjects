//
//  NotecreationView.swift
//  FireBaseNotes
//
//  Created by Никита Попов on 09.02.2021.
//

import SwiftUI

struct NotecreationView: View {
    private var noteModelView = NoteModelView()
    
    @State private var title : String = ""
    @State private var text : String = ""
    var body: some View {
        VStack {
            NavigationView {
                Form {
                    TextField("Title", text: $title)
                    TextEditor(text: $text)
                }.navigationTitle("Registration")
            }
            Button(action: {
                noteModelView.appendNote(title: self.title, text: self.text)
            }, label: {
                HStack {
                    Text("Add note").font(.headline)
                }
            }).padding()
            Spacer()
        }
    }
}

struct NotecreationView_Previews: PreviewProvider {
    static var previews: some View {
        NotecreationView()
    }
}
