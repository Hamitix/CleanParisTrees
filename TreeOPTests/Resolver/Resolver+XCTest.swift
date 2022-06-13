//
//  Resolver+XCTest.swift
//  TreeOPTests
//
//  Created by Dylan HAMITI on 10/06/2022.
//

import Foundation

import DomainLayer

import Resolver

extension Resolver {
    //MARK: Mock Container
    
    static var mock = Resolver(child: .main)

    //MARK: Register Mock Services
    static func registerMock() {
        root = Resolver.mock
        defaultScope = .application

        registerMockUseCases()
    }
    
    
    static func registerMockUseCases() {
        Resolver.mock.register {
            MockGetTreeListUseCase()
        }.implements(GetTreeList.self)
    }
}
