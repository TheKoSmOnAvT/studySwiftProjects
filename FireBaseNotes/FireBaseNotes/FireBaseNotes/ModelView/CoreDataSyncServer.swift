//
//  CoreDataSyncServer.swift
//  FireBaseNotes
//
//  Created by Никита Попов on 29.05.2021.
//

import Foundation
import CoreData

class CoreDataSyncServer {
    
    private var persistentContainer: NSPersistentContainer
    private var context: NSManagedObjectContext {
         persistentContainer.viewContext
    }
    
    //MARK: - init
    init(){
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        self.persistentContainer = container
    }
    
    //MARK: - Get,  delete NoteToCreate
    public func GetNoteToCreate() -> [NoteToCreate] {
        let request: NSFetchRequest<NoteToCreate> = NoteToCreate.fetchRequest()
        if let result = try? context.fetch(request) {
            return result
        } else {
            return []
        }
    }
    public func TruncateNoteToCreate() {
        let request : NSFetchRequest<NoteToCreate> = NoteToCreate.fetchRequest()
        if let result = try? context.fetch(request){
            for obj in result {
                context.delete(obj)
            }
            saveContext()
        }
    }
    
    //MARK: - Get,  delete NoteToDelete
    public func GetNoteToDelete() -> [NoteToDelete] {
        let request: NSFetchRequest<NoteToDelete> = NoteToDelete.fetchRequest()
        if let result = try? context.fetch(request) {
            return result
        } else {
            return []
        }
    }
    public func TruncateNoteToDelete() {
        let request : NSFetchRequest<NoteToDelete> = NoteToDelete.fetchRequest()
        if let result = try? context.fetch(request){
            for obj in result {
                context.delete(obj)
            }
            saveContext()
        }
    }
    
    
    //MARK: - Get,  delete NoteToUpdate
    public func GetNoteToUpdate() -> [NoteToUpdate] {
        let request: NSFetchRequest<NoteToUpdate> = NoteToUpdate.fetchRequest()
        if let result = try? context.fetch(request) {
            return result
        } else {
            return []
        }
    }
    public func TruncateNoteToUpdate() {
        let request : NSFetchRequest<NoteToUpdate> = NoteToUpdate.fetchRequest()
        if let result = try? context.fetch(request){
            for obj in result {
                context.delete(obj)
            }
            saveContext()
        }
    }

    
    //MARK: - save context
    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                context.rollback()
                print("An error occurred while saving: \(error)")
            }
        }
    }
    
}
