//
//  Repository+Injection.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 25/05/2022.
//

import Foundation
import Resolver

extension Resolver {
    public static func registerRepositories() {
        register { RemoteTreeRepositoryImpl() }.implements(RemoteTreeRepository.self).scope(.application)
        register { LocalTreeRepositoryImpl() }.implements(LocalTreeRepository.self).scope(.application)
        
        register { WeatherRepositoryImpl() }.implements(WeatherRepository.self).scope(.application)
    }
}
