//
//  TreeItemView.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 15/04/2022.
//

import SwiftUI
import Resolver

struct TreeItemView: View {
    
    @ObservedObject var treeItemViewModel: TreeItemViewModel
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            
            if let glTree = treeItemViewModel.glTree {
                
                NavigationLink(destination: DetailTreeView(detailViewModel: Resolver.resolve(args: glTree))) {
                    Text(LocalizedStringKey(glTree.tree.name ?? String(localized: "No Name")), comment: "treeNameComment")
                    
                    if treeItemViewModel.isFavorite {
                        Image(systemName: String(localized: "starFillIcon"))
                            .foregroundColor(.yellow)
                    }
                }
            }
        }
        .accessibilityHint("hintGoToDetailTree")
        .accessibilityLabel(String(localized: treeItemViewModel.getAccessibilityLabel()))
        
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
