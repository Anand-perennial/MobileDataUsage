//
//  MobileDataUsageViewControllerTest.swift
//  Mobile Data UsageUITests
//
//  Created by Pere Dev on 27/07/20.
//  Copyright © 2020 Perennial System. All rights reserved.
//

import XCTest
import UIKit

@testable import Mobile_Data_Usage

class MobileDataUsageViewControllerTest: XCTestCase {

    
    var viewController: MobileDataUsageViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.viewController = storyboard.instantiateViewController(withIdentifier: "MobileDataUsageViewController") as? MobileDataUsageViewController
        self.viewController.loadView()
        self.viewController.viewDidLoad()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testHasATableView() {
        XCTAssertNotNil(viewController.tableView)
    }

    func testTableViewHasDelegate() {
        XCTAssertNotNil(viewController.tableView.delegate)
    }

    func testTableViewHasDataSource() {
        XCTAssertNotNil(viewController.tableView.dataSource)
    }

    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(viewController.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(viewController.responds(to: #selector(viewController.tableView(_:viewForHeaderInSection:))))
        XCTAssertTrue(viewController.responds(to: #selector(viewController.numberOfSections(in:))))
        XCTAssertTrue(viewController.responds(to: #selector(viewController.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(viewController.responds(to: #selector(viewController.tableView(_:cellForRowAt:))))
    }

    func testTableViewCellHasReuseIdentifier() {
        let cell = viewController.tableView(viewController.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? DataUsageTableViewCell
        let actualReuseIdentifer = cell?.reuseIdentifier
        let expectedReuseIdentifier = "DataUsageTableViewCell"
        XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
    }
}
