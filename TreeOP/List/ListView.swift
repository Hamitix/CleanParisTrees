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
    
    var body: some View {
        
        VStack {
            NavigationView {
                List(listViewModel.filteredRecords) { record in
                    
                    ListItem(record: record)
                        .onAppear {
                            listViewModel.loadMoreRowsIfNeeded(currentRow: record)
                        }
                        .listRowSeparatorTint(Color("separator"))
                        .listRowSeparator(.hidden, edges: .top)
                    
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button {
                                listViewModel.toggleFavorite(record: record)
                            } label: {
                                Image(systemName: "star")
                            }
                            .tint(.yellow)
                        }
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
                .navigationViewStyle(.stack)
            }
            
            if listViewModel.isLoadingRows {
                ProgressView()
                    .padding(.bottom)
            }
        }
        .onAppear {
            self.listViewModel.setup(favTrees: self.favouriteTrees)
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
