//
//  MobileDataUsageViewModelTests.swift
//  Mobile Data UsageTests
//
//  Created by Pere Dev on 27/07/20.
//  Copyright © 2020 Perennial System. All rights reserved.
//

import Foundation
import XCTest

@testable import Mobile_Data_Usage

class MobileDataUsageViewModelTests: XCTestCase {
    var mduViewModel: MobileDataUsageViewModel!
    
    override func setUp() {
        let nwService: NetworkService = MockNetwork()
        let dbService = AppService.Database()
        dbService.clearOldDataStoreData { (status) in}
        mduViewModel = MobileDataUsageViewModel(dbService: dbService, nwService: nwService  )
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        mduViewModel = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_resource_code() {
        XCTAssertEqual(mduViewModel.resourceID, "a807b7ab-6cad-4aa6-87d0-e283a7353a0f", "Invalid resource ID.")
    }
    
    func test_fetch_mobile_data_usage_list() {
        let promise = expectation(description: "success = true")
        XCTAssertEqual(self.mduViewModel.yearsDataStore.count, 0, "Before loading the data store data should be nil")
        
        mduViewModel.fetchMobileDataUsage(resourceID: mduViewModel.resourceID, limit: 5) { (errorMsg) in
            XCTAssertNil(errorMsg, "Error occurt")
            XCTAssertGreaterThan(self.mduViewModel.yearsDataStore.count, 0, "The data store should be set")
            
            if let error = errorMsg {
                XCTFail("Error: \(error)")
                return
            } else {
                
                XCTAssertEqual(self.mduViewModel.yearsDataStore.count, 3, "Data parsing failed")
                XCTAssertGreaterThan(self.mduViewModel.getNumberOfRow(), 0, "No data to show.")
                
                promise.fulfill()
            }
        }
        wait(for: [promise], timeout: 15)
    }
    
    func test_parsing_error() {
        
        let mocNWS = mduViewModel.nwService as? MockNetwork
        mocNWS?.fileName = "MobileDataUsageParsingError"
        let promise = expectation(description: "success = true")
        mduViewModel.fetchMobileDataUsage(resourceID: mduViewModel.resourceID, limit: 200) { (errorMsg) in
            XCTAssertNotNil(errorMsg)
            promise.fulfill()
        }
        wait(for: [promise], timeout: 15)
    }
    
    func test_Internet_not_available_error() {
         
         let mocNWS = mduViewModel.nwService as? MockNetwork
         mocNWS?.isInternetAvaiable = false
         let promise = expectation(description: "success = true")
         mduViewModel.fetchMobileDataUsage(resourceID: mduViewModel.resourceID, limit: 200) { (errorMsg) in
            XCTAssertEqual(errorMsg, "Internet not available. Please try after some time");
            promise.fulfill()
         }
         wait(for: [promise], timeout: 15)
     }
    
    func test_get_number_of_rows() {
        fetchAndAssignMocData();
        XCTAssertEqual(self.mduViewModel.yearsDataStore.count, self.mduViewModel.getNumberOfRow(), "row count not matched")
    }
    
    func test_data_for_row() {
        
        fetchAndAssignMocData();
        let record = self.mduViewModel.dataForRow(row: 0)
        XCTAssertEqual(self.mduViewModel.yearsDataStore.first?.name, record?.name, "Mismatched data")
    }
    
    func test_image_status_changes() {
        
        fetchAndAssignMocData();
            let record = self.mduViewModel.yearsDataStore[0].isInfoVisiable
            let indexPath  = IndexPath.init(row: 0, section: 0)
            self.mduViewModel.changeImageStatus(indexPath: indexPath)
            XCTAssertNotEqual(record, self.mduViewModel.yearsDataStore[0].isInfoVisiable)
    }
        
    func test_Data_decrease_in_year() {
           
         fetchAndAssignMocData(fileName: "MobileUsageMockData2015")
          
            let dataDescreseInfo = self.mduViewModel.yearsDataStore.first?.decreaseVolumDataInfo()
            XCTAssertEqual(dataDescreseInfo?.0, true)

    }
    
    func test_Data_valume_for_year() {
              
              fetchAndAssignMocData(fileName: "MobileUsageMockData2015")

               let dataValume = self.mduViewModel.yearsDataStore.first?.getValumeData()
                XCTAssertEqual(dataValume!, 41.253493)
    }
        
    func test_base_url() {
        XCTAssertEqual(AppConfig.ServerBaseURL, "https://data.gov.sg/api/action/", "Base URL changed.")
    }
    
    private func fetchAndAssignMocData(fileName : String = "MobileUsageMockData")
    {
         let dto = MockDataProvider.fetchMockData(fileName: fileName)!
         mduViewModel.ceateYearWiseData(model: dto)
    }
}
