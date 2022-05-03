//
//  TreeItemView.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 15/04/2022.
//

import SwiftUI

struct TreeItemView: View {
        
    @ObservedObject private var treeItemViewModel: TreeItemViewModel
    
    init(item: GeolocatedTree){
        treeItemViewModel = TreeItemViewModel(tree: item)
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            
            if let glTree = treeItemViewModel.tree {
                
                NavigationLink(destination: DetailTreeView(glTree: glTree)) {
                    Text(LocalizedStringKey(glTree.tree.name ?? String(localized: "No Name")), comment: "treeNameComment")
                    
                    if treeItemViewModel.isFavorite {
                        Image(systemName: String(localized: "starFillIcon"))
                            .foregroundColor(.yellow)
                    }
                }
            }
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button {
                treeItemViewModel.toggleFavorite()
            } label: {
                Image(systemName: String(localized:"starIcon"))
            }
            .tint(.yellow)
        }
        .onAppear {
            treeItemViewModel.getIsFavorite()
        }
    }
}
