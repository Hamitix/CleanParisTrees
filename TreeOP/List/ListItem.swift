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
                Text(LocalizedStringKey(record.fields.name ?? "No Name"), comment: "Indicate either the title or a default placeholder")
                
                
                if favouriteTrees.isFavorite(tree: record.fields) {
                    Image(systemName: "star.fill")
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
