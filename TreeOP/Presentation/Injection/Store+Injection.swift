//
//  Store+Injection.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 27/05/2022.
//

import Foundation
import Resolver

extension Resolver {
    public static func registerStores() {
        register { BookmarkStore() }.scope(.application)
        
        register { TreeStore() }.scope(.application)
    }
}
