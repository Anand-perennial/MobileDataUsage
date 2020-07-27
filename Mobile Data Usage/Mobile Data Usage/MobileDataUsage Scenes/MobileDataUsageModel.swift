//
//  MobileDataUsageModel.swift
//  Mobile Data Usage
//
//  Created by Pere Dev on 27/07/20.
//  Copyright © 2020 Perennial Sys. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

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


class YearlyDataUsage: Codable {
    
    var name: String?
    var quarters: [Record] = [Record]()
    var isInfoVisiable = false
    
    init(name: String, quarters: [[String: String]]) {
        self.name = name
        for quarter in quarters {
            var record = Record()
            record.quarter = quarter["quarter"]
            record.volumeOfMobileData =  quarter["volumeOfMobileData"]
            self.quarters.append(record)
        }
        self.quarters.sort { (r1, r2) -> Bool in
            return r1.quarter! < r2.quarter!
        }
    }
    
    func decreaseVolumDataInfo() -> (Bool, String) {
        var valumeData = 0.0
        var infoMessage = "Data get decrease in Quarter"
        var isDecrease = false
        for quarter in quarters {
            if let volume = quarter.volumeOfMobileData, let numberData = Double(volume) {
                if numberData < valumeData {
                    infoMessage += " " + quarter.quarter!   + ","
                    isDecrease = true
                }
                valumeData = numberData
            }
        }
        infoMessage.removeLast()
        return (isDecrease, infoMessage)
    }
    
     func changeInfoVisiableStatus() {
        isInfoVisiable = !isInfoVisiable
    }
    
    func getValumeData() -> Double {
        var valumeData = 0.0
        for quarter in quarters {
            if let volume = quarter.volumeOfMobileData, let numberData = Double(volume) {
                valumeData += numberData
            }
        }
        return valumeData
    }
}

//---- Realm Object Mapping
class DataStoreModelObject: Object {
    @objc private dynamic var structData: Data?

    var model: MobileDataUsageResponseDTO? {
        get {
            if let data = structData {
                return try? JSONDecoder().decode(MobileDataUsageResponseDTO.self, from: data)
            }
            return nil
        }
        set {
            structData = try? JSONEncoder().encode(newValue)
        }
    }
}
