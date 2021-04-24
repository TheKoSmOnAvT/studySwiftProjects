//
//  NoteListView.swift
//  FireBaseNotes
//
//  Created by Никита Попов on 18.04.2021.
//

import SwiftUI

struct NoteListView: View {
    @ObservedObject var cd = CoreData()
    var body: some View {
        NavigationView {
            List(self.cd.noteList) { note in
                NavigationLink(destination: Text("Destination"))
                    {
                        Text(note.tile ?? "-")
                }
            }.onAppear  {
                self.cd.GetNotes()
            }
            .navigationBarTitle("", displayMode: .inline)
            //.navigationBarHidden(true)
        }       
    }
}

//struct NoteListView_Previews: PreviewProvider {
//    static var previews: some View {
//        NoteListView()
//    }
//}
