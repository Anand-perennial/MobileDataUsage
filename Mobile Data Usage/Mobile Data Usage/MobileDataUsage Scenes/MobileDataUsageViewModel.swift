//
//  d.swift
//  Mobile Data Usage
//
//  Created by Pere Dev on 27/07/20.
//  Copyright © 2020 Perennial Sys. All rights reserved.
//

import Foundation

class MobileDataUsageViewModel {
        
    // MARK: - Properties
    
    /// Resource ID of which you need a data.
    public let resourceID = "a807b7ab-6cad-4aa6-87d0-e283a7353a0f"
    public var yearsDataStore = [YearlyDataUsage]()
    var dbService: AppService.Database
    var nwService: NetworkService
    
    weak var delegate: MobileDataUsageViewModelDelegate?

    init(dbService: AppService.Database, nwService: NetworkService) {
        self.dbService = dbService
        self.nwService = nwService
    }
    
    // MARK: - Functions
    
    /// Fetch mobile usage data.
    /// - Parameters:
    ///   - resourceID: Resource ID of which you need a data.
    ///   - limit: Record limit
    ///   - completionHandler: Error message if occured.
    public func fetchMobileDataUsage(resourceID: String, limit: Int = 5, non completionHandler: @escaping (_ errorMeesage: String?) -> Void) {
        
        
        let param: [String: Any] = ["resource_id": resourceID, "limit": limit]
        self.nwService.request(url: "datastore_search", method: .get, parameters: param, headers: [:], uRLEncoding: .default) { (result: Result<MobileDataUsageResponseDTO, APIError>) in
            //--- Validate result status
            switch result {
            case .success(let model):
                self.ceateYearWiseData(model: model)
               
                self.delegate?.showData()
                completionHandler(nil)
            case .failure(let error):
                
                var message = error.localizedDescription
                if error.internetNotAvailble {
                    message = "Internet not available. Please try after some time"
                }
                    completionHandler(message)
            }
        }
    }
    
    func ceateYearWiseData(model: MobileDataUsageResponseDTO) {
                
        var data: [String: [[String: String]]] = [ : ]
        for record in model.result.records {
            
            let yearQuarter = record.quarter?.components(separatedBy: "-")
            var quartersData = data[yearQuarter?.first ?? ""] ?? [[String: String]]()
            var quarter = [String: String]()
            quarter["quarter"] = yearQuarter?.last
            quarter["volumeOfMobileData"] = record.volumeOfMobileData
            quartersData.append(quarter)
            data[yearQuarter!.first!] = quartersData
        }
        
        yearsDataStore.removeAll()

        for (name, quarter) in data {
            yearsDataStore.append(YearlyDataUsage(name: name, quarters: quarter))
        }
        yearsDataStore.sort { (y1, y2) -> Bool in
            return y1.name! > y2.name!
        }
    }
}

extension MobileDataUsageViewModel: MobileDataUsageViewModelInput {
    func doSomethingOnViewLoad() {
        delegate?.showLoadingActivity()
        self.fetchMobileDataUsage(resourceID: self.resourceID, limit: 2000) { _ in
            self.delegate?.hideLoadingActivity()
        }
    }
    
    func changeImageStatus(indexPath: IndexPath) {
        yearsDataStore[indexPath.row].changeInfoVisiableStatus()
        delegate?.reloadTableViewForIndexPath(indexPath: indexPath)
    }
    func getScreenTitle() -> String {
        return "Mobile Data Usage"
    }
    
    /// Description
    func getNumberOfSection() -> Int {
        return yearsDataStore.isEmpty ? 0 : 1
    }

    /// Description
    func getNumberOfRow() -> Int {
        return yearsDataStore.count
    }
    
    /// Fetch data model
    /// - Parameter row: Index number for which you need a data.
    func dataForRow(row: Int) -> YearlyDataUsage? {
            return yearsDataStore[row]
    }
}
