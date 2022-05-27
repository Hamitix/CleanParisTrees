//
//  DataSource+Injection.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 25/05/2022.
//

import Foundation
import Resolver

extension Resolver {
    public static func registerDataSources() {
        register { RemoteTreeDataSourceImpl() }.implements(RemoteTreeDataSource.self).scope(.application)
        register { LocalTreeDataSourceImpl() }.implements(LocalTreeDataSource.self).scope(.application)
        
        register { WeatherDataSourceImpl() }.implements(WeatherDataSource.self).scope(.application)
    }
}
