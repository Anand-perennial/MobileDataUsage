//
//  ViewModelFactory.swift
//  Mobile Data Usage
//
//  Created by Pere Dev on 27/07/20.
//  Copyright © 2020 Perennial Sys. All rights reserved.
//

import Foundation

enum ViewModelType {
   case modelDataUsage
}

class ViewModelFactory {
    
    static func getViewModel(type: ViewModelType) -> BaseViewModel? {
        switch type {
        case .modelDataUsage:
            let dbService = AppService.Database()
            let nwService = AppService.Network()
            let mobileDataUsage = MobileDataUsageViewModel.init(dbService: dbService, nwService: nwService)
            return mobileDataUsage
        }
    }
}
