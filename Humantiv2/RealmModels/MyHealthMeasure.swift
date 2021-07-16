//
//  MyEvent.swift
//  HealthKitMonitoringWorkshop
//
//  Created by Mark Pruit on 2/20/21.
//

import Foundation
import RealmSwift
import IceCream
import CloudKit

//class Card: Object, Identifiable {
class MyHealthMeasure: Object, Identifiable {
    @objc dynamic var id = NSUUID().uuidString
    @objc dynamic var date: Date = Date()
    @objc dynamic var event = ""
    @objc dynamic var notes = ""
    @objc dynamic var isDeleted = false
    
    override class func primaryKey() -> String? {
            return "id"

    }
}

extension MyHealthMeasure: CKRecordConvertible & CKRecordRecoverable {
    // Leave it blank to usee private database, uncomment and change in AppDelegate to usee public
    //static var databaseScope: CKDatabase.Scope { .public }
    
}
