//
//  ListItem.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 15/04/2022.
//

import SwiftUI

struct ListItem: View {
    
    @EnvironmentObject var favouriteTrees: FavouriteTrees
    
    let record: RecordsData
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            
            NavigationLink(destination: DetailView(record: record)) {
                Text(LocalizedStringKey(record.fields.name ?? String(localized: "No Name")), comment: "treeNameComment")
                
                
                if favouriteTrees.isFavorite(tree: record.fields) {
                    Image(systemName: String(localized: "starFillIcon"))
                        .foregroundColor(.yellow)
                }
            }
        }
    }
}

struct ListItem_Previews: PreviewProvider {
    static var previews: some View {
        ListItem(record: RecordsData.sampleData)
    }
}
