//
//  ListItem.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 15/04/2022.
//

import SwiftUI

struct ListItem: View {
    
    let record: RecordsData
    
    @EnvironmentObject var favouriteTrees: FavouriteTrees
    
    var body: some View {
        NavigationLink(destination: DetailView(record: record)) {
            
            HStack {
                Text(LocalizedStringKey(record.fields.name ?? "No Name"), comment: "Indicate either the title or a default placeholder")
                
                Spacer()
                displayStarIcon()
            }
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button {
                toggleFavorite()
            } label: {
                displayStarIcon()

            }
            .tint(.yellow)
        }
    }
    
    func toggleFavorite() {
        favouriteTrees.toggleFavorite(tree: self.record.fields)
    }
    
    func displayStarIcon() -> Image {
        return  Image(systemName: favouriteTrees.isFavorite(tree: self.record.fields) ? "star.fill" : "star")
    }
}

struct ListItem_Previews: PreviewProvider {
    static var previews: some View {
        ListItem(record: RecordsData.sampleData)
    }
}
