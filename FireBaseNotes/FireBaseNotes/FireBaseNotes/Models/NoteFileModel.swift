//
//  NoteFileModel.swift
//  FireBaseNotes
//
//  Created by Никита Попов on 24.03.2021.
//

import Foundation

public class NoteFileModel {
    private var titleNote : String
    private var textNote : String
    
    public var title : String{
        return self.titleNote
    }
    
    public var text : String{
        return self.textNote
    }
    
    public init(title : String, text : String){
        self.textNote = text
        self.titleNote = title
    }
    public init() {
        self.textNote = "noteText"
        self.titleNote = "title"
    }
    
}
