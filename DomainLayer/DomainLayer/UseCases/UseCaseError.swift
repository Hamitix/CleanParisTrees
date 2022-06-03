//
//  UseCaseError.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 25/04/2022.
//

import Foundation

public enum UseCaseError: Error {
    case networkError
    case decodingError
    case retrievingFromDBError
}
