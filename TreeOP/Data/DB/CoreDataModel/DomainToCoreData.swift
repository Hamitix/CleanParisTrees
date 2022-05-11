//
//  DataToCoreData.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 09/05/2022.
//

import Foundation

protocol DomainToTreeCoreData {
    associatedtype M: Any
    func ToTreeCoreData() -> M
}

protocol DomainToGLTreeCoreData {
    associatedtype M: Any
    func ToGLTreeCoreData() -> M
}
