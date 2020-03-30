//
//  Entry.swift
//  JournalCK
//
//  Created by David on 3/30/20.
//  Copyright © 2020 David. All rights reserved.
//

import CloudKit

struct EntryConstants{
    static let titleKey = "title"
    static let bodyKey = "body"
    static let timestampKey = "timestamp"
    static let recordTypeKey = "Entry"
    
}

class Entry {
    let title: String
    let body: String
    let timestamp: Date
    let ckRecordID: CKRecord.ID
      
    init(title: String, body: String, timestamp: Date = Date(), ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.title = title
        self.body = body
        self.timestamp = timestamp
        self.ckRecordID = ckRecordID
      }
}

extension CKRecord {
convenience init(entry: Entry) {
    self.init(recordType: EntryConstants.recordTypeKey, recordID: entry.ckRecordID)
    self.setValuesForKeys([
        EntryConstants.titleKey : entry.title,
        EntryConstants.bodyKey : entry.body,
        EntryConstants.timestampKey : entry.timestamp
    ])
}
}

extension Entry {
    convenience init?(ckRecord: CKRecord) {
        guard let title = ckRecord[EntryConstants.titleKey] as? String,
            let body = ckRecord[EntryConstants.bodyKey] as? String,
            let timestamp = ckRecord[EntryConstants.timestampKey] as? Date else {return nil}
        self.init(title: title, body: body, timestamp: timestamp)
    }
}
