//
//  ViewModel+Injection.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 30/05/2022.
//

import Foundation
import Resolver

extension Resolver {
    public static func registerViewModels() {
        
        // Tree
        register { TreeListViewModel() }.implements(TreeListVMProtocol.self).scope(.application)
        
        register { _, args in
            TreeItemViewModel(tree: args())
        }
        
        register  { _, args in
            DetailTreeViewModel(glTree: args.optional())
        }
        
        // Map
        register { MapViewModel() }.implements(MapVMProtocol.self).scope(.application)
        
        // Weather Info
        register { WeatherInfoViewModel() }.implements(WeatherInfoVMProtocol.self).scope(.application)
    }
}
