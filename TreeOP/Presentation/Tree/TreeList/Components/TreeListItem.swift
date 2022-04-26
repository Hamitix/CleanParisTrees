//
//  ListItem.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 15/04/2022.
//

import SwiftUI

struct TreeListItem: View {
    
    @EnvironmentObject var favouriteTrees: FavouriteTrees
    
    let item: GeolocatedTree
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            
            NavigationLink(destination: DetailTreeView(tree: item)) {
                Text(LocalizedStringKey(item.tree.name ?? String(localized: "No Name")), comment: "treeNameComment")
                
                
                if favouriteTrees.isFavorite(tree: item.tree) {
                    Image(systemName: String(localized: "starFillIcon"))
                        .foregroundColor(.yellow)
                }
            }
        }
    }
}

//struct ListItem_Previews: PreviewProvider {
//    static var previews: some View {
//        ListItem(record: RecordsData.sampleData)
//    }
//}
