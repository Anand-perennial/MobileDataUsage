//
//  MobileDataUsageModel.swift
//  Mobile Data Usage
//
//  Created by Pere Dev on 27/07/20.
//  Copyright © 2020 Perennial System. All rights reserved.
//

import Foundation

// MARK: - MobileDataUsageResponseDTO
public struct MobileDataUsageResponseDTO: Codable {
    let help: String
    let success: Bool
    var result: DataStoreModel
}

// MARK: - DataStoreModel
public struct DataStoreModel: Codable {
    var resourceID: String
    var fields: [Field]
    var records: [Record]
    var links: Links
    var limit, total: Int
    
    enum CodingKeys: String, CodingKey {
        case resourceID = "resource_id"
        case fields, records
        case links = "_links"
        case limit, total
    }
}

// MARK: - Field
public struct Field: Codable {
    let type, fieldID: String
    
    enum CodingKeys: String, CodingKey {
        case type
        case fieldID = "id"
    }
}

// MARK: - Links
public struct Links: Codable {
    let start, next: String
}

// MARK: - Record
struct Record: Codable {
    var volumeOfMobileData, quarter: String?
    var recordID: Int?
    
    enum CodingKeys: String, CodingKey {
        case volumeOfMobileData = "volume_of_mobile_data"
        case quarter
        case recordID = "_id"
    }
    init() {}
}
