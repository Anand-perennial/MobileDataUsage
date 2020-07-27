//
//  Protocols.swift
//  Mobile Data Usage
//
//  Created by Pere Dev on 27/07/20.
//  Copyright © 2020 Perennial Sys. All rights reserved.
//

import Foundation


protocol BaseViewModel: class {
    
}

protocol MobileDataUsageViewModelDelegate: class {
    func showLoadingActivity()
    func hideLoadingActivity()
    func showData()
    func showError(message: String)
    func reloadTableViewForIndexPath(indexPath: IndexPath)
}

protocol MobileDataUsageViewModelInput: BaseViewModel {
    var delegate: MobileDataUsageViewModelDelegate? { get set }
   
    func doSomethingOnViewLoad()
    func dataForRow(row: Int) -> YearlyDataUsage?
    func getNumberOfRow() -> Int
    func getNumberOfSection() -> Int
    func changeImageStatus(indexPath: IndexPath)
    func getScreenTitle() -> String
}
