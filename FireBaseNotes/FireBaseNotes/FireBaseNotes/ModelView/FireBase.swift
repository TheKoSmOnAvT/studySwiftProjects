//
//  FireBase.swift
//  FireBaseNotes
//
//  Created by Никита Попов on 07.02.2021.
//

import Foundation
import Firebase

public class FireBase {
    
    var reference: DatabaseReference!
    
    init() {
        FirebaseApp.configure()
        reference = Database.database().reference()
    }
    
    
    
    func registration(mail : String, password  : String) ->  String {
        var result =  ""
        self.reference.child("users").child(mail).child("id").observeSingleEvent(of: .value, with: { (snapshot) in
                   if let id = snapshot.value  {
                    if("\(id)" == "<null>") {
                            let id = UUID().uuidString
                            var hash  = Hasher()
                            hash.combine(password)
                            let resultHash  =  hash.finalize()
                            self.reference.child("users").child(mail).setValue(["id" : id,  "password" : resultHash])
                            result = id
                        }
                   }
               })
        return result
    }
    
    func login(mail : String, password  : String) {
        var hash  = Hasher()
        hash.combine(password)
        let resultHash  =  hash.finalize()
        self.reference.child("users").child(mail).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let result = snapshot.value as? [String : Any] {
                print("2222")
                    print(result["password"])
                print("222")
                
            }
            
                print("123")
        })
    }
    
    
    
    func appendNote(title : String, text :  String){
        let id = UUID().uuidString
        self.reference.child("Note").child(id).setValue(["title" : title,  "text" :text])
    }
}

    
    
    
//    func  getData() {
//        self.ref.child("note").child("UUID").child("message").observeSingleEvent(of: .value, with: { (snapshot) in
//            if let id = snapshot.value  {
//                print("The value from the database: \(id)")
//            }
//        })
//    }
//}

