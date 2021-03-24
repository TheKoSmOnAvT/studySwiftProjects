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
    
    var reference: DatabaseReference!
    @Published var notLoginStatus : Bool = false
    
    init() {
        FirebaseApp.configure()
        reference = Database.database().reference()
    }
    
    
    
    func registration(mail : String, password  : String) ->  Bool {
        var result =  false
        self.reference.child("users").child(mail).child("id").observeSingleEvent(of: .value, with: { (snapshot) in
                   if let id = snapshot.value  {
                    if("\(id)" == "<null>") {
                            let id = UUID().uuidString
                            let hash  =  self.MD5(string: password)
                            let hashString = hash.map { String(format: "%02hhx", $0) }.joined()
                            self.reference.child("users").child(mail).setValue(["id" : id,  "password" : String(hashString)])
                            result = true
                        }
                   }
               })
        return result
    }
    
    func login(mail : String, password  : String) {
        self.logout()
        let mailTrim = mail.trimmingCharacters(in: .whitespacesAndNewlines)
        let passwordTrim = password.trimmingCharacters(in: .whitespacesAndNewlines)
        let group = DispatchGroup() 
        if(mailTrim.isEmpty || passwordTrim.isEmpty )  {
            return
        }
        let hash  =  MD5(string: passwordTrim)
        let hashString = hash.map { String(format: "%02hhx", $0) }.joined()
        self.reference.child("users").child(mailTrim).observeSingleEvent(of: .value, with: { (snapshot) in
            if let result = snapshot.value as? [String : Any] {
                if let pass = result["password"] as? String, let id = result["id"] as? String  {
                    if (pass  ==  hashString){
                        group.enter()
                        print(id);
                        self.notLoginStatus = false
                        print(self.notLoginStatus);
                        UserDefaults.standard.setValue(id, forKey: DefaultProfile.authId.rawValue)
                        group.leave()
                    } else {
                        self.notLoginStatus = true
                    }
               }
            }
        })
    }
    
    func logout() {
        UserDefaults.standard.setValue(nil, forKey: DefaultProfile.authId.rawValue)
        notLoginStatus = true
    }
    
    
    func appendNote(_  note : NoteFileModel){
        let id = UUID().uuidString
        self.reference.child("Note").child(id).setValue(["title" : note.title,  "text" : note.text])
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

