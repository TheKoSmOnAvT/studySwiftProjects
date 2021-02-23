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
                            let hash  =  self.MD5(string: password)
                            let hashString = hash.map { String(format: "%02hhx", $0) }.joined()
                            self.reference.child("users").child(mail).setValue(["id" : id,  "password" : String(hashString)])
                            result = id
                        }
                   }
               })
        return result
    }
    
    func login(mail : String, password  : String) {
        let hash  =  MD5(string: password)
        let hashString = hash.map { String(format: "%02hhx", $0) }.joined()
        self.reference.child("users").child(mail).observeSingleEvent(of: .value, with: { (snapshot) in
            if let result = snapshot.value as? [String : Any] {
                if let pass = result["password"] as? String, let id = result["id"] as? String  {
                    if (pass  ==  hashString){
                        UserDefaults.standard.setValue(id, forKey: DefaultProfile.authId.rawValue)
                    }
               }
            }
        })
    }
    
    func logout() {
        UserDefaults.standard.setValue(nil, forKey: DefaultProfile.authId.rawValue)
    }
    
    
    func appendNote(title : String, text :  String){
        let id = UUID().uuidString
        self.reference.child("Note").child(id).setValue(["title" : title,  "text" :text])
    }
    
    
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

    

    
    
//    func  getData() {
//        self.ref.child("note").child("UUID").child("message").observeSingleEvent(of: .value, with: { (snapshot) in
//            if let id = snapshot.value  {
//                print("The value from the database: \(id)")
//            }
//        })
//    }
//}

