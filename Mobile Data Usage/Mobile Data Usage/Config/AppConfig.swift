//
//  AppConfig.swift
//  Mobile Data Usage
//
//  Created by Pere Dev on 27/07/20.
//  Copyright © 2020 Perennial Sys. All rights reserved.
//

import Foundation

/// Base app configuration model
internal struct AppConfig {
    /// Base URL to be used accrose all the API request. can add and use for mulitple targates as well. QA, PROD, Staging and Release etc.
    static let ServerBaseURL = "https://data.gov.sg/api/action/"
}
