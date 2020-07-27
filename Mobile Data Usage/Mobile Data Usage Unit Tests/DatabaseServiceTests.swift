//
//  DatabaseServiceTests.swift
//  Mobile Data UsageTests
//
//  Created by Pere Dev on 27/07/20.
//  Copyright © 2020 Perennial System. All rights reserved.
//

import Foundation

import Foundation
import XCTest
import Realm
import RealmSwift

@testable import Mobile_Data_Usage

class DatabaseServiceTests: XCTestCase {
    
    var dbService: AppService.Database? = AppService.Database()
    var dataStoreModelObject: DataStoreModelObject? = DataStoreModelObject()
    
    override func setUp() {
        super.setUp()
        
        dbService?.clearOldDataStoreData(completionHandler: { (_) in
        })
    }
    
    override func tearDown() {
        super.tearDown()
        
        //dbService = nil
        //dataStoreModelObject = nil
    }
    
    func test_save_record() {
        dataStoreModelObject?.model = MockDataProvider.fetchMockData()
        let promise = expectation(description: "Data saved successfully.")
        
        dbService?.saveRecord(object: dataStoreModelObject!) { (isSuccess) in
            XCTAssertTrue(isSuccess, "Failed to save the record.")
            promise.fulfill()
        }
        wait(for: [promise], timeout: 10)
    }
    
    func test_fetch_record() {
        
        let model = MockDataProvider.fetchMockData()
        
        dataStoreModelObject?.model = model
        let promise = expectation(description: "Data fetched successfully.")
        
        dbService?.saveRecord(object: dataStoreModelObject!) { (isSuccess) in
            XCTAssertTrue(isSuccess, "Failed to save the record.")
            
            dataStoreModelObject?.model = model
            _ = try? XCTUnwrap(dbService, "Failed to unwrap dbService instance")
            
            dbService?.fetchRecords(ofType: dataStoreModelObject!) { (arrData) in
                //XCTAssertGreaterThan(arrData.count, 1, "Has previous data to show.")
                XCTAssertNotEqual(arrData.count, 0, "No data to display.")
                promise.fulfill()
            }
            
        }
        wait(for: [promise], timeout: 10)
    }
    
    func test_delete_record() {
        let model = MockDataProvider.fetchMockData()
        dataStoreModelObject?.model = model
        _ = try? XCTUnwrap(dbService, "Failed to unwrap dbService instance")
        let promise = expectation(description: "Data deleted successfully.")
        
        dbService?.saveRecord(object: dataStoreModelObject!) { (isSuccess) in
            XCTAssertTrue(isSuccess, "Failed to save the record.")
            
            dbService?.deleteRecord(object: dataStoreModelObject!) { (isSuccess) in
                XCTAssertTrue(isSuccess, "Failed to save the record.")
                promise.fulfill()
            }
        }
        
        wait(for: [promise], timeout: 10)
    }
    
    func test_clear_all_dataStoreData() {
        _ = try? XCTUnwrap(dbService, "Failed to unwrap dbService instance")
        let promise = expectation(description: "Data deleted successfully.")
        
        dbService?.clearOldDataStoreData(completionHandler: { (isDeleted) in
            XCTAssertTrue(isDeleted, "Failed to delete all cache data.")
            
            if isDeleted {
                promise.fulfill()
            }
        })
        wait(for: [promise], timeout: 10)
    }
}
