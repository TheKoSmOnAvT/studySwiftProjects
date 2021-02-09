//
//  NoteView.swift
//  FireBaseNotes
//
//  Created by Никита Попов on 09.02.2021.
//

import Foundation
import Firebase
public class NoteModelView {
    var reference : DatabaseReference
    
    init(){
        FirebaseApp.configure()
        reference = Database.database().reference()
    }
    
    func appendNote(title : String, text :  String){
        let id = UUID().uuidString
        self.reference.child("Note").child(id).setValue(["title" : title,  "text" :text])
    }
}
