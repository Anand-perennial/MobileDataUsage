//
//  Alamofire+Codable.swift
//  Mobile Data Usage
//
//  Created by Pere Dev on 27/07/20.
//  Copyright © 2020 Perennial Sys. All rights reserved.
//

import Foundation

import Alamofire

internal extension Alamofire.DataRequest {

    @discardableResult
    func responseCodable<T: Decodable>(
        file: String = #file, line: Int = #line, function: String = #function,
        _ type: T.Type,
        decoder: JSONDecoder = JSONDecoder(),
        completion: @escaping (Swift.Result<T, APIError>) -> Void
    ) -> Alamofire.DataRequest {
        return self.responseData { dataResponse in
            if dataResponse.response?.statusCode == 200, let data = dataResponse.value {
                do {
                    completion(.success(try decoder.decode(type, from: data)))
                } catch {
                    let parseError = ParseError(error, file: file, line: line, function: function)
                    completion(.failure(APIError.init(parseError: parseError, error: nil, data: nil)))
                }
            } else {
                completion(.failure(APIError.init(parseError: nil, error: dataResponse.error, data: dataResponse.data)))
            }
        }
    }
}
