//
//  MockGetTreeListUseCase.swift
//  TreeOPTests
//
//  Created by Dylan HAMITI on 13/06/2022.
//

import Foundation
import XCTest

import APILayer
import DomainLayer


public struct MockGetTreeListUseCase: GetTreeList {
    
    var geolocatedTrees: [GeolocatedTree] = [ ]
    
    public func fetch(startRow: Int, isLazy: Bool, fetchStrategy: FetchStrategy) async -> Result<[GeolocatedTree], UseCaseError> {
        
        var trees: [GeolocatedTree] = []
        
        do {
            let data = try XCTestCase().getLocalData(fileName: "MockGeolocatedTreeDataMain", extensionName: "json")
            
            trees = try JSONDecoder().decode([GeolocatedTree].self, from: data)
            
            
            if trees.isEmpty {
                return .failure(.decodingError)
            }
            
            return .success(trees)
        } catch {
            return .failure(.retrievingFromDBError)
        }
    }
}
