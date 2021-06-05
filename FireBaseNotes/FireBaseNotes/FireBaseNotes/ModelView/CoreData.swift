//
//  CoreData.swift
//  FireBaseNotes
//
//  Created by Никита Попов on 18.04.2021.
//

import Foundation
import CoreData

public class CoreData : ObservableObject {
    @Published var noteList : [Note]  = []
    
    private var persistentContainer  :  NSPersistentContainer
    private var context: NSManagedObjectContext {
         persistentContainer.viewContext
    }
    
    init(){
        let container = NSPersistentContainer(name: "DB")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        self.persistentContainer = container
    }
    
    //MARK: - Update Collection
    public func GetNotes() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        if let result = try? context.fetch(fetchRequest) as? [Note] {
            self.noteList = result.count == 0 ? [] : result
        } else {
            self.noteList = []
        }
    }
    

    public func GetNotesStatus() {
        print("#####Note######")
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        if let result = try? context.fetch(fetchRequest) as? [Note] {
            for i in result{
                print(i)
                print(i.id)
            }
        }
        print("#####NoteToCreate######")
        let fetchRequest1 = NSFetchRequest<NSFetchRequestResult>(entityName: "NoteToCreate")
        if let result = try? context.fetch(fetchRequest1) as? [NoteToCreate] {
            for i in result{
                print(i)
                print(i.id)
            }
        }
        print("#####NoteToUpdate######")
        let fetchRequest3 = NSFetchRequest<NSFetchRequestResult>(entityName: "NoteToUpdate")
        if let result = try? context.fetch(fetchRequest3) as? [NoteToUpdate] {
            for i in result{
                print(i)
                print(i.id)
            }
        }
        print("#####NoteToDelete######")
        let fetchRequest5 = NSFetchRequest<NSFetchRequestResult>(entityName: "NoteToDelete")
        if let result = try? context.fetch(fetchRequest5) as? [NoteToDelete] {
            for i in result{
                print(i)
                print(i.id)
            }
        }
        
    }
    
    
    //MARK: - CRUD NoteModel
    private func AddNoteModel(_ note : NoteFileModel) -> UUID? {
        let newEnity = Note(context: context)
        if note.title == "" || note.text == ""  { return nil }
        newEnity.id = note.id
        newEnity.title = note.title
        newEnity.text = note.text
        saveContext()
        return newEnity.id
    }
    private func ChangeNoteModel(_ note : NoteFileModel) -> Bool {
        let predicate = NSPredicate(format: "id == %@", note.id as CVarArg)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Note")
        fetchRequest.predicate = predicate
        fetchRequest.fetchLimit = 1
        let results = try! context.fetch(fetchRequest)
        if results.isEmpty {
            return false
        }
        let object = results.first as! Note
        object.text = note.text
        object.title = note.title
        saveContext()
        return true
    }
    private func DeleteNoteModel(_ note : Note) {
        let predicate = NSPredicate(format: "id == %@", note.id! as CVarArg)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Note")
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
        let predicate = NSPredicate(format: "id == %@", note.id as CVarArg)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "NoteToUpdate")
        fetchRequest.predicate = predicate
        fetchRequest.fetchLimit = 1
        let results = try! context.fetch(fetchRequest)
        if !results.isEmpty {
            let object = results.first as! NoteToUpdate
            object.text = note.text
            object.title = note.title
        } else {
            let newEnity = NoteToUpdate(context: context)
            newEnity.id = note.id
            newEnity.title = note.title
            newEnity.text = note.text
        }
        saveContext()
    }
    private func AddNoteToDelete(_ note : Note) {
        let newEnity = NoteToDelete(context: context)
        newEnity.id = note.id 
        saveContext()
    }

    //MARK: - CRUD
    public func AddNote(note : NoteFileModel) {
        if let id = AddNoteModel(note) {
            AddNoteToCreate(note)
        } else {
            print("$$$$error to create")
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
    
    private func DeleteByIndexNote(_ index : IndexSet) -> Note? {
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
  //////////
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
    //////////
    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                context.rollback()
                print("%%%%%%%%")
                print("An error occurred while saving: \(error)")
            }
        }
        self.noteList = []
        GetNotes()
    }
}
