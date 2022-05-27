//
//  Add+Injection.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 03/05/2022.
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        defaultScope = .graph
        
        registerDataSources()
        registerRepositories()
        registerUseCases()
        registerStores()
        
        register { NetworkMonitor.shared }.scope(.application)
    }
}
