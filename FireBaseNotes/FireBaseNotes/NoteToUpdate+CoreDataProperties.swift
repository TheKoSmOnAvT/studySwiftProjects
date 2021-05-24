//
//  NoteToUpdate+CoreDataProperties.swift
//  FireBaseNotes
//
//  Created by Никита Попов on 24.05.2021.
//
//

import Foundation
import CoreData


extension NoteToUpdate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteToUpdate> {
        return NSFetchRequest<NoteToUpdate>(entityName: "NoteToUpdate")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var text: String?
    @NSManaged public var title: String?

}

extension NoteToUpdate : Identifiable {

}
