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
    
    public func GetNotes() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NoteModel.fetchRequest()
        if let result = try? context.fetch(fetchRequest) as? [NoteModel] {
            self.noteList = result
        }
    }
    
    public func AddNote(note : NoteFileModel){
        let newEnity = NoteModel(context: context)
        if note.title == "" || note.text == ""  { return }
        newEnity.id = UUID()
        newEnity.title = note.title
        newEnity.text = note.text
        saveContext()
    }
    
    public func ChangeNote(note : NoteFileModel) {
        let predicate = NSPredicate(format: "id == %@", note.id as CVarArg)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "NoteModel")
        fetchRequest.predicate = predicate
        fetchRequest.fetchLimit = 1
        let results = try! context.fetch(fetchRequest)
        if results.isEmpty {
            return
        }
        let object = results.first as! NoteModel
        object.text = note.text
        object.title = note.title
        saveContext()
    }
    
    public func DeleteNote(note : NoteModel) {
        let predicate = NSPredicate(format: "id == %@", note.id! as CVarArg)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "NoteModel")
        fetchRequest.predicate = predicate
        fetchRequest.fetchLimit = 1
        let results = try! context.fetch(fetchRequest)
        context.delete(results.first as! NSManagedObject)
        saveContext()
    }
    
    public func DeleteByIndexNote(index : IndexSet) {
        let ind : Int = index.first ?? -1
        if ind != -1 {
            var check :  Int = 0
            for obj in noteList {
                if(check == ind ) {
                    self.noteList.remove(at: ind)
                    DeleteNote(note: obj)
                    return
                }
                check = check + 1
            }
        }
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
