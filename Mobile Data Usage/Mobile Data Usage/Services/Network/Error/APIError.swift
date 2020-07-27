//
//  APIError.swift
//  Mobile Data Usage
//
//  Created by Pere Dev on 27/07/20.
//  Copyright © 2020 Perennial Sys. All rights reserved.
//

import Alamofire
import Foundation

/// API error model to represent the API error.
public struct APIError: Swift.Error {
    
    /// It represents parse failure info.
    var parseError: ParseError?
    
    /// It represents error
    var error: Error?
    
    /// Other data
    var data: Data?
    
    var internetNotAvailble = false
}
