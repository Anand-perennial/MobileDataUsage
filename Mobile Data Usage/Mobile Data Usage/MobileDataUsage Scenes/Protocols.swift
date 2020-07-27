//
//  Protocols.swift
//  Mobile Data Usage
//
//  Created by Pere Dev on 27/07/20.
//  Copyright © 2020 Perennial System. All rights reserved.
//

import Foundation

protocol BaseViewModel: class {
    
}

protocol MobileDataUsageViewModelInput: BaseViewModel {
   
    func doSomethingOnViewLoad()
}
