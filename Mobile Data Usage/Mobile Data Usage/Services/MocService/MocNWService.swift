
//
//  File.swift
//  Mobile Data Usage
//
//  Created by Pere Dev on 27/07/20.
//  Copyright © 2020 Perennial System. All rights reserved.
//

import Foundation
import Alamofire

public class MockNetwork: NetworkService {
    
    var fileName = "MobileUsageMockData"
    var isInternetAvaiable = true
    
    public func request<T>(url: String, method: HTTPMethod, parameters: [String: Any]?, headers: HTTPHeaders, uRLEncoding: URLEncoding, completion: @escaping (Result<T, APIError>) -> Void) where T: Decodable {
        if(!isInternetAvaiable)
        {
            var error = APIError()
            error.internetNotAvailble = !isInternetAvaiable
            completion(.failure(error))
            return
        }
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let model = try decoder.decode(T.self, from: data)
                completion(.success(model))
                
            } catch {
                let parseError = ParseError(error, file: #file, line: #line, function: #function)
                completion(.failure(APIError(parseError: parseError, error: nil, data: nil)))
            }
        }
    }
}

class MockDataProvider {
    class func fetchMockData(fileName: String = "MobileUsageMockData") -> MobileDataUsageResponseDTO? {
        if let mockData = SerializeUtility.readJSONFromFile(fileName: fileName, type: MobileDataUsageResponseDTO.self) {
            return mockData
        } else {
            return nil
        }
    }
}

