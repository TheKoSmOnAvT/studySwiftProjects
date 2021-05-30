//
//  FireBase.swift
//  FireBaseNotes
//
//  Created by Никита Попов on 07.02.2021.
//

import Foundation
import Firebase
import Foundation
import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG

public class FireBase : ObservableObject{
    var reference: DatabaseReference?
    var db: CoreDataSyncServer  = CoreDataSyncServer()
    @Published var notLoginStatus : Bool = false
    var id : String? {
        return UserDefaults.standard.object(forKey: DefaultProfile.authId.rawValue) as? String
    }
    
    init() {
        //TO DO: - сбрасывается при перезапуске
        self.notLoginStatus = checkNotLoginStatus()
        FirebaseApp.configure()
        reference = Database.database().reference()
    }
    
    //MARK: - Account
    private func checkNotLoginStatus() -> Bool {
        let id = UserDefaults.standard.object(forKey: DefaultProfile.authId.rawValue)
        if (id == nil) {
            return true
        } else {
            return false
        }
    }
    public func registration(mail : String, password  : String) ->  Bool {
        var result =  false
        if(self.reference  != nil) {
            self.reference!.child("users").child(mail).child("id").observeSingleEvent(of: .value, with: { (snapshot) in
                   if let id = snapshot.value  {
                    if("\(id)" == "<null>") {
                            let id = UUID().uuidString
                            let hash  =  self.MD5(string: password)
                            let hashString = hash.map { String(format: "%02hhx", $0) }.joined()
                        self.reference!.child("users").child(mail).setValue(["id" : id,  "password" : String(hashString)])
                            result = true
                        }
                   }
               })
        }
        return result
    }
    public func login(mail : String, password  : String) {
        if(self.reference  != nil) {
        self.logout()
        let mailTrim = mail.trimmingCharacters(in: .whitespacesAndNewlines)
        let passwordTrim = password.trimmingCharacters(in: .whitespacesAndNewlines)
        let group = DispatchGroup() 
        if(mailTrim.isEmpty || passwordTrim.isEmpty )  {
            return
        }
        let hash  =  MD5(string: passwordTrim)
        let hashString = hash.map { String(format: "%02hhx", $0) }.joined()
        self.reference!.child("users").child(mailTrim).observeSingleEvent(of: .value, with: { (snapshot) in
            if let result = snapshot.value as? [String : Any] {
                if let pass = result["password"] as? String, let id = result["id"] as? String  {
                    if (pass  ==  hashString){
                        group.enter()
                        print(id);
                        self.notLoginStatus = false
                        UserDefaults.standard.setValue(id, forKey: DefaultProfile.authId.rawValue)
                        group.leave()
                    } else {
                        self.notLoginStatus = true
                    }
               }
            }
        })
        }
    }
    
    public func logout() {
        UserDefaults.standard.setValue(nil, forKey: DefaultProfile.authId.rawValue)
        notLoginStatus = true
    }
    
    //MARK: - Note CRUD
    public func SyncData(){
        let userId =  self.id ?? nil
        if(!notLoginStatus && userId != nil) {
            NoteToCreate(userId!)
            NoteToUpdate(userId!)
            NoteToDelete(userId!)
            UpdateLocalStorage(userId!)
        }
    }
    
    private func NoteToCreate(_ userId : String){
        let objs = db.GetNoteToCreate()
        for obj in objs {
            FBAddNote(userId, obj)
        }
        db.TruncateNoteToCreate()
    }

    private func NoteToUpdate(_ userId : String){
        let objs = db.GetNoteToUpdate()
        for obj in objs {
            FBUpdateNote(userId, obj)
        }
        db.TruncateNoteToUpdate()
    }
    
    private func NoteToDelete(_ userId : String){
        let objs = db.GetNoteToDelete()
        for obj in objs {
            FBDeleteNote(userId, obj)
        }
        db.TruncateNoteToDelete()
    }
    
    //MARK:  -  fire base data
    private func FBHasNote(_ userId : String, _ uuidString : String) -> Bool {
        var ch = false;
        if(self.reference  != nil) {
        DispatchQueue.global(qos: .default).sync {
            self.reference!.child("note").child(userId).child(uuidString).observeSingleEvent(of: .value) { dataSnapshot in
                if dataSnapshot.value == nil {
                    ch = false
                } else {
                    ch = true
                }
            }
        }
        }
        return ch
    }
    
    private func FBAddNote(_ userId : String, _  note : NoteToCreate){
        if(self.reference != nil  && !FBHasNote(userId,note.id!.uuidString)){
            self.reference!.child("Note").child(userId).child(note.id!.uuidString).setValue(["title" : note.title,  "text" : note.text])
        }
    }
    
    private func FBUpdateNote(_ userId : String, _  note : NoteToUpdate){
        if(self.reference  != nil) {
        let childUpdates = ["/Note/\(userId)/\(note.id!.uuidString)/text": note.text,
                            "/Note/\(userId)/\(note.id!.uuidString)/title": note.title]
        reference!.updateChildValues(childUpdates as [AnyHashable : Any])
        }
    }
    
    private func FBDeleteNote(_ userId : String, _  note : NoteToDelete){
        if(self.reference  != nil && note.id != nil) {
            self.reference!.child("Note").child(userId).child(note.id!.uuidString).child("title").removeValue { error, arg   in
                if error != nil {
                    print("error \(String(describing: error))")
                }
              }
            self.reference!.child("Note").child(userId).child(note.id!.uuidString).child("text").removeValue { error, arg  in
                if error != nil {
                    print("error \(String(describing: error))")
                }
              }
            self.reference!.child("Note").child(userId).child(note.id!.uuidString).removeValue {
                error, arg  in
                if error != nil {
                    print("error \(String(describing: error))")
                }
              }
        }
    }
    
    private func UpdateLocalStorage(_ userId : String){
            FBGetNote(userId) { notes in
                self.db.TruncateNoteModel()
                self.AddNotesToLocalStorage(notes)
            }
    }
    
    private func AddNotesToLocalStorage(_ notes : [NoteFileModel]){
        for note in notes {
            self.db.AddNoteModel(note)
        }
    }
     
    private func FBGetNote(_ userId : String, completion: @escaping ([NoteFileModel]) -> Void) {
        if(self.reference  != nil) {
            self.reference!.child("Note").child(userId).observeSingleEvent(of: .value, with: { DataSnapshot in
                var collection : [NoteFileModel] = []
                    if let ch = DataSnapshot.value as? [String:[String:String]] {
                        for i in ch {
                            let value = i.value
                            collection.append(NoteFileModel(id: UUID(uuidString: i.key)! , title: value["title"]!, text: value["text"]!))
                        }
                        completion(collection)
                    } else {
                        print("Error to Get Note by Fire Base")
                        completion( [])
                    }
                })
        } else {
            completion( [])
        }
    }
    
    
    
//    private func FBGetNote(_ userId : String) -> [NoteFileModel]{
//        if(self.reference  != nil) {
//            var collection : [NoteFileModel] = []
//            let group = DispatchGroup()
//            group.enter()
//            self.reference!.child("Note").child(userId).observeSingleEvent(of: .value, with: { DataSnapshot in
//                    if let ch = DataSnapshot.value as? [String:[String:String]] {
//                        for i in ch {
//                            let value = i.value
//                            collection.append(NoteFileModel(id: UUID(uuidString: i.key)! , title: value["title"]!, text: value["text"]!))
//                        }
//                    } else {
//                        print("Error to Get Note by Fire Base")
//                    }
//                })
//            group.wait()
//            return collection
//        } else {
//            return []
//        }
//    }
    
   //MARK: - hash
   private func MD5(string: String) -> Data {
            let length = Int(CC_MD5_DIGEST_LENGTH)
            let messageData = string.data(using:.utf8)!
            var digestData = Data(count: length)

            _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
                messageData.withUnsafeBytes { messageBytes -> UInt8 in
                    if let messageBytesBaseAddress = messageBytes.baseAddress, let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                        let messageLength = CC_LONG(messageData.count)
                        CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
                    }
                    return 0
                }
            }
            return digestData
        }
}
