//
//  NoteFileModel.swift
//  FireBaseNotes
//
//  Created by Никита Попов on 24.03.2021.
//

import Foundation

public class NoteFileModel {
    private var idNote : UUID
    private var titleNote : String
    private var textNote : String
    
    public var title : String{
        return self.titleNote
    }
    
    public var id : UUID{
        return self.idNote
    }
    
    public var text : String{
        return self.textNote
    }
    
    public init(title : String, text : String){
        self.textNote = text
        self.titleNote = title
        self.idNote = UUID()
    }
    
    public init() {
        self.idNote = UUID()
        self.textNote = "noteText"
        self.titleNote = "title"
    }
    public init(id : UUID, title : String, text : String){
        self.textNote = text
        self.titleNote = title
        self.idNote = id
    }
    
}
