//
//  DataToDomain.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 22/04/2022.
//

import Foundation

protocol DataToDomain {
    associatedtype M: Any
    func ToDomain() -> M
}
