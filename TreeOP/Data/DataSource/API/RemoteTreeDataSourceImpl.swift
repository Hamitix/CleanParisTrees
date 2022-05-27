//
//  RemoteTreeDataSourceImpl.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 22/04/2022.
//

import Foundation

struct RemoteTreeDataSourceImpl
: RemoteTreeDataSource {
   
    func getTreeListRemote(startRow: Int, nbRows: Int) async throws -> [GeolocatedTree] {
        guard let url = URL(string: String(localized: "urlOpenDataURL \(nbRows) \(startRow)")) else {
            throw APIServiceError.badUrl
        }
                
        guard let (data, response) = try? await URLSession.shared.data(from: url) else {
            throw APIServiceError.requestError
        }
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw APIServiceError.statusNotOK
        }
                
        guard let result = try? JSONDecoder().decode(Records.self, from: data) else {
            throw APIServiceError.decodingError
        }
        
        return result.records.map { item in
            GeolocatedTree(tree: item.fields.TreeDataToDomain(), lng: item.geometry.coordinates[0], lat: item.geometry.coordinates[1])
        }
    }
}
