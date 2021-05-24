//
//  NoteFileModel.swift
//  FireBaseNotes
//
//  Created by Никита Попов on 24.03.2021.
//

import Foundation

public class NoteFileModel {
    public var id : UUID
    public var title : String
    public var text : String
    
    public init(title : String, text : String){
        self.text = text
        self.title = title
        self.id = UUID()
    }
    
    public init() {
        self.id = UUID()
        self.text = ""
        self.title = ""
    }
    public init(id : UUID, title : String, text : String){
        self.text = text
        self.title = title
        self.id = id
    }
    
}
