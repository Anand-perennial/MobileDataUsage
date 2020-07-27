//
//  DBService.swift
//  Mobile Data Usage
//
//  Created by Pere Dev on 27/07/20.
//  Copyright © 2020 Perennial Sys. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

extension AppService {
    
    /// Database service class to interact with DB.
    public class Database: NSObject {
        
        let realmDB = try? Realm()
        
        /// Save data object into the database.
        /// - Parameters:
        ///   - object: Object to be saved
        ///   - completionHandler: Status of save operation. TRUE => For success and FALSE => When operation fails.
        func saveRecord(object: Object, completionHandler: ( (Bool) -> Void)) {
            guard let realm = self.realmDB else {
                completionHandler(false)
                return
            }
            
            if let fileURL = self.realmDB?.configuration.fileURL {
                print("Realm Path: \(fileURL.absoluteString)")
            }
            
            do {
                try realm.safeWrite {
                    realm.add(object)
                    completionHandler(true)
                }
            } catch {
                completionHandler(false)
            }
        }
        
        /// Delete data object from database
        /// - Parameters:
        ///   - object: Object to be deleted
        ///   - completionHandler: Status of delete operation. TRUE => For success and FALSE => When operation fails.
        func deleteRecord(object: Object, completionHandler: ( (Bool) -> Void)) {
            guard let realm = self.realmDB else {
                completionHandler(false)
                return
            }
            
            do {
                try realm.safeWrite {
                    realm.delete(object)
                    completionHandler(true)
                }
            } catch {
                completionHandler(false)
            }
        }
        
        /// Returns list of objects requested for the data object
        /// - Parameters:
        ///   - ofType: Object Type
        ///   - whereClause: Filter condition
        ///   - completionHandler: List of object requested.
        func fetchRecords<T>(ofType: T, whereClause: String? = nil, completionHandler: ( ([T]) -> Void)) where T: Object {
            guard let realm = self.realmDB else {
                completionHandler([])
                return
            }
            
            var objs: Results<T>
            if let filter = whereClause {
                objs = realm.objects(T.self).filter(filter)
            } else {
                objs = realm.objects(T.self)
            }
            
            if objs.isEmpty == false {
                var dumppyStudents = [T]()
                for student in objs {
                    dumppyStudents.append(student)
                }
                completionHandler(dumppyStudents)
            } else {
                completionHandler([])
            }
        }
        
        func clearOldDataStoreData(completionHandler: ( (Bool) -> Void)) {
            self.fetchRecords(ofType: DataStoreModelObject()) { (arrDataStoreModelObjects) in
                arrDataStoreModelObjects.forEach { (dataStoreModelObject) in
                    self.deleteRecord(object: dataStoreModelObject) { (isDeleted) in
                        debugPrint("Deleted successfully? : \(isDeleted ? "YES" : "NO")")
                    }
                }
                completionHandler(true)
            }
        }
    }
}

extension Realm {
    /// Validated the current state and returns the safe block.
    public func safeWrite(_ block: (() throws -> Void)) throws {
        if isInWriteTransaction {
            try block()
        } else {
            try write(block)
        }
    }
}
