//
//  AccountFireBase.swift
//  FireBaseNotes
//
//  Created by Никита Попов on 09.02.2021.
//

import Foundation
import Firebase

public class AccountFireBase {
    var reference : DatabaseReference
    
    init() {
        //FirebaseApp.configure()
        reference = Database.database().reference()
        self.registation(mail : "mail",  password : "123")
    }
    
    
    func registation(mail : String, password : String){
        self.reference.child("users").child(mail).observeSingleEvent(of: .value, with: { (snapshot) in
                print("T: \(snapshot)")
                   if let id = snapshot.value  {
                       print("The value from the database: \(id)")
                   }
               })
    }
}
