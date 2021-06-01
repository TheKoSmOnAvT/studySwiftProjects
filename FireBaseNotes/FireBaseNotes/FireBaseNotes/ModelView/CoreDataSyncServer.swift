//
//  CoreDataSyncServer.swift
//  FireBaseNotes
//
//  Created by Никита Попов on 29.05.2021.
//

import Foundation
import CoreData

class CoreDataSyncServer : ObservableObject {
    
    private var persistentContainer: NSPersistentContainer
    private var context: NSManagedObjectContext {
         persistentContainer.viewContext
    }
    
    //MARK: - init
    init(){
        let container = NSPersistentContainer(name: "DB")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })

        self.persistentContainer = container
    }
    
    //MARK: - Get,  delete NoteToCreate
    public func GetNoteToCreate() -> [NoteToCreate] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "NoteToCreate")
        if let result = try? context.fetch(request) as? [NoteToCreate] {
            return result
        } else {
            return []
        }
    }
    public func TruncateNoteToCreate() {
        let request = NSFetchRequest<NSManagedObject>(entityName: "NoteToCreate")
        if let result = try? context.fetch(request){
            for obj in result {
                context.delete(obj)
            }
            saveContext()
        }
    }
    
    //MARK: - Get,  delete NoteToDelete
    public func GetNoteToDelete() -> [NoteToDelete] {
        let request  = NSFetchRequest<NSFetchRequestResult>(entityName: "NoteToDelete")
        if let result = try? context.fetch(request) as? [NoteToDelete] {
            return result
        } else {
            return []
        }
    }
    public func TruncateNoteToDelete() {
        let request = NSFetchRequest<NSManagedObject>(entityName: "NoteToDelete")
        if let result = try? context.fetch(request){
            for obj in result {
                context.delete(obj)
            }
            saveContext()
        }
    }
    
    
    //MARK: - Get,  delete NoteToUpdate
    public func GetNoteToUpdate() -> [NoteToUpdate] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "NoteToUpdate")
        if let result = try? context.fetch(request)  as?  [NoteToUpdate] {
            return result
        } else {
            return []
        }
    }
    public func TruncateNoteToUpdate() {
        let request = NSFetchRequest<NSManagedObject>(entityName: "NoteToUpdate")
        if let result = try? context.fetch(request){
            for obj in result {
                context.delete(obj)
            }
            saveContext()
        }
    }
    
    //MARK: - Add ,  delete NoteModel
    public func AddNoteModel(_ note : NoteFileModel)  {
            let newEnity = Note(context: context)
            newEnity.id = note.id
            newEnity.title = note.title
            newEnity.text = note.text
            saveContext()
    }
    
    public func TruncateNoteModel() {
        let request = NSFetchRequest<NSManagedObject>(entityName: "Note")
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
