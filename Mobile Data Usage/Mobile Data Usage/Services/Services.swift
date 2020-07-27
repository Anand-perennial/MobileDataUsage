//
//  Services.swift
//  Mobile Data Usage
//
//  Created by Pere Dev on 27/07/20.
//  Copyright © 2020 Perennial Sys. All rights reserved.
//

import Foundation
import Alamofire
/// Base service namespacing model.
public struct AppService { }

public protocol NetworkService: class {
    
    func request<T: Decodable>(url: String, method: HTTPMethod, parameters: [String: Any]?, headers: HTTPHeaders, uRLEncoding: URLEncoding, completion:@escaping (Result<T, APIError>) -> Void)
}
