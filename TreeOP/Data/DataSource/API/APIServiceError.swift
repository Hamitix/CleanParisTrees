//
//  APIServiceError.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 25/04/2022.
//

import Foundation

enum APIServiceError : Error {
    case badUrl
    case requestError
    case decodingError
    case statusNotOK
}
