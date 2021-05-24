//
//  NoteToDelete+CoreDataProperties.swift
//  FireBaseNotes
//
//  Created by Никита Попов on 24.05.2021.
//
//

import Foundation
import CoreData


extension NoteToDelete {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteToDelete> {
        return NSFetchRequest<NoteToDelete>(entityName: "NoteToDelete")
    }

    @NSManaged public var id: UUID?

}

extension NoteToDelete : Identifiable {

}
