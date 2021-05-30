//
//  NoteListView.swift
//  FireBaseNotes
//
//  Created by Никита Попов on 18.04.2021.
//

import SwiftUI

struct NoteListView: View {
    @ObservedObject var cd : CoreData 
    //var fb : FireBase
    fileprivate func AddNoteButton() -> some View {
        return HStack{
            NavigationLink(destination:
                            NoteCreationView(cd: self.cd)
            ) {
                Text("Add note")
                    .foregroundColor(.black)
                    .bold()
                    .padding(8)
                    .background(
                        ContainerRelativeShape()
                            .fill(Color.white)
                            .cornerRadius(16)
                    )
            }
            .statusBar(hidden: true)
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
            
        }
        .frame(height: 60, alignment: .center)
    }
    
    fileprivate func NoteTitle() -> some View {
        return HStack {
            Text("Notes")
                .font(.system(size: 40, weight: .thin))
                .bold()
                .foregroundColor(.white)
        }
        .padding(6)
        .frame(maxWidth: .infinity)
    }
    
    fileprivate func HeadList() -> some View {
        return VStack {
            NoteTitle()
            AddNoteButton()
        }
        .background(
            RadialGradient(gradient:  Gradient(colors: [ .black, .pink]),
                           center: .center,
                           startRadius: 100,
                           endRadius: 200)
                .edgesIgnoringSafeArea(.top))
    }
    
    var body: some View {
            NavigationView {
            VStack {
                HeadList()
                List {
                ForEach(self.cd.noteList, id :\.id ) { note in
                    NavigationLink(destination: ChangeNoteView(cd: cd, id: note.id!, title : note.title  ?? "", text: note.text ?? "")) {
                        NoteRowView(note: note)
                    }
                }.onDelete(perform: delete)
                }
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarHidden(true)
            }
        }.onAppear {
            self.cd.GetNotes()
    }
    }
    
    private func delete(with indexSet: IndexSet) {
        self.cd.DeleteNote(index: indexSet)
    }
}




struct NoteRowView: View {
    @ObservedObject var note: NoteModel
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(note.title ?? "-").bold()            }
            Spacer()
        }
    }
}
