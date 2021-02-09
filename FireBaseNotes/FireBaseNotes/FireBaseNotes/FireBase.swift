//
//  FireBase.swift
//  FireBaseNotes
//
//  Created by Никита Попов on 07.02.2021.
//

import Foundation
import Firebase

public class FireBase {
    var ref: DatabaseReference!
    init() {
        FirebaseApp.configure()
        ref = Database.database().reference()
        
        
        self.ref.child("note").child("UUID").setValue(["":""])
     //   getData()
    }
//    func  getData() {
//        self.ref.child("note").child("UUID").child("message").observeSingleEvent(of: .value, with: { (snapshot) in
//            if let id = snapshot.value  {
//                print("The value from the database: \(id)")
//            }
//        })
//    }
}

