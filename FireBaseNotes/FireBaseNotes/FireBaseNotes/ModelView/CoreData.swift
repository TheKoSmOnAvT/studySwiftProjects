//
//  CoreData.swift
//  FireBaseNotes
//
//  Created by Никита Попов on 18.04.2021.
//

import Foundation
import CoreData

public class CoreData : ObservableObject {
    @Published var noteList : [NoteModel]
    
    private var persistentContainer: NSPersistentContainer
    private var context: NSManagedObjectContext {
         persistentContainer.viewContext
    }
    
    init(){
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        self.persistentContainer = container
        noteList = []
    }
    
    //MARK: - Update Collection
    public func GetNotes() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NoteModel")
        if let result = try? context.fetch(fetchRequest) as? [NoteModel] {
            self.noteList = result
        }
    }
    
    //MARK: - CRUD NoteModel
    private func AddNoteModel(_ note : NoteFileModel) -> UUID? {
        let newEnity = NoteModel(context: context)
        if note.title == "" || note.text == ""  { return nil }
        newEnity.id = UUID()
        newEnity.title = note.title
        newEnity.text = note.text
        saveContext()
        return newEnity.id
    }
    private func ChangeNoteModel(_ note : NoteFileModel) -> Bool {
        let predicate = NSPredicate(format: "id == %@", note.id as CVarArg)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "NoteModel")
        fetchRequest.predicate = predicate
        fetchRequest.fetchLimit = 1
        let results = try! context.fetch(fetchRequest)
        if results.isEmpty {
            return false
        }
        let object = results.first as! NoteModel
        object.text = note.text
        object.title = note.title
        saveContext()
        return true
    }
    private func DeleteNoteModel(_ note : NoteModel) {
        let predicate = NSPredicate(format: "id == %@", note.id! as CVarArg)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "NoteModel")
        fetchRequest.predicate = predicate
        fetchRequest.fetchLimit = 1
        let results = try! context.fetch(fetchRequest)
        context.delete(results.first as! NSManagedObject)
        saveContext()
    }
    
    //MARK: - server update note data
    private func AddNoteToCreate(_ note : NoteFileModel) {
        let newEnity = NoteToCreate(context: context)
        newEnity.id = note.id
        newEnity.title = note.title
        newEnity.text = note.text
        saveContext()
    }
    private func AddNoteToUpdate(_ note : NoteFileModel) {
        let newEnity = NoteToUpdate(context: context)
        newEnity.id = note.id
        newEnity.title = note.title
        newEnity.text = note.text
        saveContext()
    }
    private func AddNoteToDelete(_ note : NoteModel) {
        let newEnity = NoteToDelete(context: context)
        newEnity.id = note.id 
        saveContext()
    }

    //MARK: - CRUD
    public func AddNote(note : NoteFileModel){
        if let id = AddNoteModel(note) {
            note.id = id
            AddNoteToCreate(note)
        }
    }
    public func ChangeNote(note : NoteFileModel) {
        let check = ChangeNoteModel(note)
        if(check){
            AddNoteToUpdate(note)
        }
    }
    public func DeleteNote(index : IndexSet) {
        if let note = DeleteByIndexNote(index) {
            AddNoteToDelete(note)
            DeleteNoteModel(note)
        }
    }
    
    private func DeleteByIndexNote(_ index : IndexSet) -> NoteModel? {
        let ind : Int = index.first ?? -1
        if ind != -1 {
            var check :  Int = 0
            for obj in noteList {
                if(check == ind ) {
                    let objectToDelete = obj
                    self.noteList.remove(at: ind)
                    return objectToDelete
                }
                check = check + 1
            }
        }
        return nil
    }
    
    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                context.rollback()
                print("An error occurred while saving: \(error)")
            }
        }
        self.noteList = []
        GetNotes()
    }
}
