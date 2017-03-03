//
//  Contact.swift
//  CloudKitChallenge
//
//  Created by Michael Castillo on 3/3/17.
//  Copyright © 2017 Michael Castillo. All rights reserved.
//

import Foundation
import CloudKit

struct Contact {

    let name: String
    let email: String
    let phoneNumber: String
    // TODO: - come back and do this record
    var cloudKitRecordID: CKRecordID?
    
    init(name: String, email: String, phoneNumber: String) {
        self.name = name
        self.email = email
        self.phoneNumber = phoneNumber
    
    }
    
    var CKRepresentation: CKRecord {
        var recordID: CKRecordID = cloudKitRecordID ?? CKRecordID(recordName: UUID().uuidString)
        let record = CKRecord(recordType: "Contact")
        record.setValue(name, forKey: nameKey)
        record.setValue(email, forKey: emailKey)
        record.setValue(phoneNumber, forKey: phoneNumberKey)
        return record
    }
    
    fileprivate let nameKey = "name"
    fileprivate let phoneNumberKey = "phoneNumber"
    fileprivate let emailKey = "email"
    
}


// MARK: - failable init

extension Contact {

    init?(cloudKitRecord: CKRecord) {
    guard let name = cloudKitRecord[nameKey] as? String,
        let email = cloudKitRecord[emailKey] as? String,
        let phoneNumber = cloudKitRecord[phoneNumberKey] as? String
        else { return nil }
        
        self.name = name
        self.email = email
        self.phoneNumber = phoneNumber
    }
}
