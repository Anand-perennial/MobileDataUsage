//
//  d.swift
//  Mobile Data Usage
//
//  Created by Pere Dev on 27/07/20.
//  Copyright © 2020 Perennial System. All rights reserved.
//

import Foundation

class MobileDataUsageViewModel {

    // MARK: - Properties
    
    /// Resource ID of which you need a data.
    public let resourceID = "a807b7ab-6cad-4aa6-87d0-e283a7353a0f"
    var dbService: AppService.Database
    var nwService: NetworkService
    
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
}

extension MobileDataUsageViewModel : MobileDataUsageViewModelInput
{
    func doSomethingOnViewLoad() {
          self.fetchMobileDataUsage(resourceID: self.resourceID, limit: 2000) { _ in

        }
      }
}
