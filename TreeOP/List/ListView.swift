//
//  ContentView.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 08/04/2022.
//

import SwiftUI


struct ListView: View {
    
    @EnvironmentObject var favouriteTrees: FavouriteTrees
    
    @StateObject private var listViewModel: ListViewModel
    
    init(viewModel: ListViewModel = .init()) {
        _listViewModel = StateObject(wrappedValue: viewModel)
    }
    
    var filteredRecords : [RecordsData] {
        switch listViewModel.isFilteringFavourites {
        case false:
            return listViewModel.records
         case true:
            return listViewModel.records.filter { favouriteTrees.isFavorite(tree: $0.fields) }
        }
    }
    
    var body: some View {
        
        VStack {
            NavigationView {
                List{
                    ForEach(filteredRecords, id: \.self) { record in
                        ListItem(record: record)
                            .onAppear {
                                listViewModel.loadMoreRowsIfNeeded(currentRow: record)
                            }
                        }
                    .listRowSeparatorTint(Color("separator"))
                    .listRowSeparator(.hidden, edges: .top)
                }
                .listStyle(.inset)
                .padding(.trailing)
                .animation(.default, value: listViewModel.isFilteringFavourites)
                .toolbar(content: {
                    Button {
                        listViewModel.toggleFilterFavourites()
                    } label: {
                        Text(LocalizedStringKey(listViewModel.filterButtonName))
                    }

                })
                .navigationTitle(Text("titleMainView"))
            }
            
            if(listViewModel.isLoadingRows) {
                ProgressView()
                    .padding(.bottom)
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
