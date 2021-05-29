//
//  NoteModel+CoreDataProperties.swift
//  FireBaseNotes
//
//  Created by Никита Попов on 24.05.2021.
//
//

import Foundation
import CoreData


extension NoteModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteModel> {
        return NSFetchRequest<NoteModel>(entityName: "NoteModel")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var text: String?
    @NSManaged public var title: String?

}

extension NoteModel : Identifiable {

}