//
//  NotecreationView.swift
//  FireBaseNotes
//
//  Created by Никита Попов on 09.02.2021.
//

import SwiftUI

struct NoteCreationView: View {
    var cd : CoreData
    @State public var title : String = ""
    @State public var text : String = ""
    @Environment(\.presentationMode) var presentation
    
    private var actionButton : Bool {
        return text == "" || title == ""
    }
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .center, spacing: 15) {
                Spacer()
                TextField("Title", text: $title)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                
                TextEditor(text: $text)
                    .frame(
                           height: UIScreen.main.bounds.size.height * 0.6,
                           alignment: .center)
                    .cornerRadius(12)
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))

                Button(action: {
                    cd.AddNote(note: NoteFileModel(title: self.title, text: self.text))
                    self.presentation.wrappedValue.dismiss()
                }, label: {
                        Text("Add note")
                            .font(.custom( "Helvetica Neue",fixedSize: 20))
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                })
                .disabled(actionButton)
                Spacer()
            }
        }.background(
            LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing)
        )
    }
}
