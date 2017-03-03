//
//  ContactController.swift
//  CloudKitChallenge
//
//  Created by Michael Castillo on 3/3/17.
//  Copyright © 2017 Michael Castillo. All rights reserved.
//

import Foundation
import CloudKit

struct ContactController {

   static let publicCKDatabase = CKContainer.default().publicCloudDatabase
}

extension ContactController {

    //MARK: - Save
    
   static func saveContact(name: String, email: String, phoneNumber: String) {
    
        let contact = Contact(name: name, email: email, phoneNumber: phoneNumber)
        let contactCKRecord = contact.CKRepresentation
        
        publicCKDatabase.save(contactCKRecord) { (_, error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        
    }
    
    //MARK: - Load
    
    static func loadContact(completion: @escaping([Contact]) -> Void) {
    
        let predicate = NSPredicate(value: true)
        
        let query = CKQuery(recordType: "Contact", predicate: predicate)
        
        publicCKDatabase.perform(query, inZoneWith: nil) { (records, error) in
            guard let record = records else { return }
            
            let records = record.flatMap ({ Contact(cloudKitRecord: $0) })
            
            completion(records)
        }
    }
    
    //MARK: - Delete
    
    
    static func deleteRecordWithID(_ recordID: CKRecordID, completion: ((_ recordID: CKRecordID?, _ error: Error?) -> Void)?) {
        
        publicCKDatabase.delete(withRecordID: recordID) { (recordID, error) in
            completion?(recordID, error)
        }
    }
    
}
