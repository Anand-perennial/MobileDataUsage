//
//  NetworkService.swift
//  Mobile Data Usage
//
//  Created by Pere Dev on 27/07/20.
//  Copyright © 2020 Perennial Sys. All rights reserved.
//

import Foundation
import Alamofire

extension AppService {
    
    /// Network service to manage network requests.
    class Network: NetworkService {
        
        /// Function to fetch data from the  server with the help of provided parameters.
        /// - Parameters:
        ///   - url: URL to be used to fetch the resource
        ///   - method: HTTP method
        ///   - parameters: Parameters to be sent along with request.
        ///   - headers: HTTP headers
        ///   - uRLEncoding: Encoding type.
        ///   - completion: Returns result mode with success and failure case.
        public func request<T: Decodable>(url: String, method: HTTPMethod, parameters: [String: Any]?, headers: HTTPHeaders, uRLEncoding: URLEncoding, completion:@escaping (Result<T, APIError>) -> Void) {
            
            if !NetworkReachabilityManager()!.isReachable {
                var apiError = APIError()
                apiError.internetNotAvailble = true
                completion(.failure(apiError))
                return
            }
            let apiUrl = AppConfig.ServerBaseURL + url
            let request = AF.request(apiUrl, method: method, parameters: parameters, encoding: uRLEncoding, headers: headers).validate()
            
            request.responseCodable(T.self) { result in
                switch result {
                case .success(let model):
                    completion(.success(model))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
