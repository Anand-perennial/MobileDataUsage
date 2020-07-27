//
//  ParseError.swift
//  Mobile Data Usage
//
//  Created by Pere Dev on 27/07/20.
//  Copyright © 2020 Perennial Sys. All rights reserved.
//

import Foundation

/// Parser model to represent the parsing failure.
public struct ParseError: Swift.Error {
    public let error: Error?
    public let file: String
    public let line: Int
    public let function: String
    
    /// Initialiser
    /// - Parameters:
    ///   - error: Error model
    ///   - file: File in which it occured.
    ///   - line: Line number at which error was triggered.
    ///   - function: Function name at which error was triggered.
    public init(_ error: Error?, file: String = #file, line: Int = #line, function: String = #function) {
        self.error = error
        self.file = file
        self.line = line
        self.function = function
    }
}
