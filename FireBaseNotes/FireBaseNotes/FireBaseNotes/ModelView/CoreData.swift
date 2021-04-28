//
//  CoreData.swift
//  FireBaseNotes
//
//  Created by Никита Попов on 18.04.2021.
//

import Foundation
import CoreData

public class CoreData : ObservableObject {
    @Published var noteList : [NoteModel] = []
    
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
    }
    
    public func GetNotes(){
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NoteModel.fetchRequest()
        if let result = try? context.fetch(fetchRequest) as? [NoteModel] {
            self.noteList = result
        }
    }
    
    public func AddNote(note : NoteFileModel){
        let newEnity = NoteModel(context: context)
        newEnity.id = UUID()
        newEnity.title = note.title
        newEnity.text = note.text
        if context.hasChanges {
                  do {
                      try context.save()
                  } catch {
                    context.rollback()
                      let nserror = error as NSError
                      fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                  }
              }
        
    }
    
    public func ChangeNote(note : NoteFileModel) {
        
    }
    
    public func DeleteNote(note : NoteFileModel) {
        //let delete = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        //try context.execute(delete)
        
    }
    
}
