//
//  XCTestCase.swift
//  TreeOPTests
//
//  Created by Dylan HAMITI on 13/06/2022.
//

import XCTest

import DomainLayer

enum TestError: Error {
    case fileNotFound
}

extension XCTestCase {
    
    func getLocalData(fileName: String, extensionName: String) throws -> Data {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: extensionName) else {
            XCTFail("Missing file: \(fileName).json")
            throw TestError.fileNotFound
        }
        
        do {
            return try Data(contentsOf: url)
        } catch {
            throw error
        }
    }
}
