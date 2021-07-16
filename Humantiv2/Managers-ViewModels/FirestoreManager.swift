//
//  FirestoreManager.swift
//  Humantiv2
//
//  Created by Mark Pruit on 6/23/21.
//

import Foundation

class FirestoreManager {
    //Firestore array help functions
    func fsDoubleArrayofDictCreator (doubleArray: [Double]) -> [[String: Double]] {
    var avgArrayofDict: [[String: Double]] = []
    var itemCounter = 0
    for _ in doubleArray {
        avgArrayofDict.append(["doubleValue":doubleArray[itemCounter]])
        itemCounter += 1
    }
    return avgArrayofDict
    }

    func fsStringArrayofDictCreator (stringArray: [String]) -> [[String: String]] {
    var stringArrayofDict: [[String: String]] = []
    var itemCounter = 0
    for _ in stringArray {
        stringArrayofDict.append(["stringValue": stringArray[itemCounter]])
        itemCounter += 1
    }
    return stringArrayofDict
    }
}
