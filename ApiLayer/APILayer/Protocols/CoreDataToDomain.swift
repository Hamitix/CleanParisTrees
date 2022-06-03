//
//  CoreDataToDomain.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 09/05/2022.
//

import Foundation

public protocol CoreDataToGLTreeDomain {
    associatedtype M: Any
    func CDToGLTreeDomain() throws -> M
}


public protocol CoreDataToTreeDomain {
    associatedtype M: Any
    func CDToTreeDomain() -> M
}

