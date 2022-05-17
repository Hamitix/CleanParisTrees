//
//  getTreeListLoca.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 16/05/2022.
//

import Foundation

struct GetTreeListLocal : getTreeList {
    
    func fetch(startRow: Int, isLazy: Bool) -> Result<[GeolocatedTree], UseCaseError> {
        let localTreeRepo = LocalTreeRepositoryImpl(dataSource: GetTreesDBImpl())

        do {
            let trees = try localTreeRepo.getTreeList(offset: startRow, isLazy: isLazy)
            return .success(trees)
            
        } catch {
            return .failure(UseCaseError.retrievingFromDBError)
        }
    }
}
