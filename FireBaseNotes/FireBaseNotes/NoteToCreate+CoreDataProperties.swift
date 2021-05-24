//
//  NoteToCreate+CoreDataProperties.swift
//  FireBaseNotes
//
//  Created by Никита Попов on 24.05.2021.
//
//

import Foundation
import CoreData


extension NoteToCreate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteToCreate> {
        return NSFetchRequest<NoteToCreate>(entityName: "NoteToCreate")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var text: String?
    @NSManaged public var title: String?

}

extension NoteToCreate : Identifiable {

}
